Return-Path: <linux-kernel+bounces-864354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C9BFA9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04A605035B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA792FAC16;
	Wed, 22 Oct 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eph8PPfN"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00245350A0E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118617; cv=none; b=fOxTjfh7r9Pz9k3U9ngGvNPXIzsVclhAbF2Ck6g9BfV7k93V1dWyH4ZAl/THZJ92X8IMaJD9KyyQK88QTaLt0xKv8DFix2VJ/AaX+SDYIIakc0soGJ//g3LACZeDPbdvzW+KDaUQi4p2Xw4gsNwDldWVGEH5/++NAUuwQdtM7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118617; c=relaxed/simple;
	bh=4tO1WXj6WgZlOPA0xz+u1lIl6OAiRpneHrXjRc8x+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfzLcSbbStwgVIe2exoh9nB4f8Tcsbhith4iPCX3PCTAZqWN3oDPfmCG0ce4CCDffaIp281n3kjarTtIdEy0JnhhwHKRfaWCCin1fcuEu/3SuoCUtBSiTvrpD0yWtB4UwTapXfIvgDccDxxBSxGRNwVkp3nFys6RlB1+wNvio8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eph8PPfN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so8423192f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761118614; x=1761723414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYRODrAioifNQsfmynSYmORQ4CX7Cpc9gXZU06Vn+0w=;
        b=eph8PPfNeP3TLxPQyS9dvxqx1NtpioA81JfW9GOlmGQZtEjmY1MhTH2Q3y4AHMxZV7
         gv2rwEJmvEc7LSqMpQkLlZb0pjHPpTGx0nrOKIVErKQ7XJ8fBybgNsbxUOx5G41ZeZVV
         YjxHF6+BuwqW++pCMKwHY8SXA7ODHgGtssdaabiv9KybiOjbcoMdB4cg7RnpFMcNgl09
         mrrGmfZBKwLE3NOcWIp+rHe+H9XcFQE+aTUGL6WLFE6dG2D7WsQLq0KdhEjWubNkhyeW
         M8cmMSopQHziDbpgP8y+ayPyz+V6gMPPCQv14bbF4MJLy6PnX+rQXF0k2ahDkjmax9AC
         YUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118614; x=1761723414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYRODrAioifNQsfmynSYmORQ4CX7Cpc9gXZU06Vn+0w=;
        b=hYnDjbpKMxrV3EPZcFuI3BhpewCXWEz/KCDHgUw8l83tlnC7HsBtI5r8ynJrYAhQUD
         Fh5EdmF/E97tODYmlCVpe+9zpHIPrsT1BgsQvWaMXw+gCuf2jRWVDIL16WkSsTt/Bc1U
         Piqw0drKOdNtfXzH9BLpm91n2MZwUnO+bL7J7BdpOnnQSiFnpTgUbTRrJUDR79aOJjp3
         bixKVvIM8P3zkApyDARuQAbnWjzRoMuuPky6Coeg693dgbnqwYcyM9C91AfQEfb5uJl8
         8aZHhHQxvPe69OzvRr3PsJ8peVRay35e0GO7CgTjB/dL13UsGBT87fNxaaQUuaYde8nT
         /ODw==
X-Forwarded-Encrypted: i=1; AJvYcCXf7MhFbVAxfqJITtrgn5UbyN4eGGDRbDsrV8Q2SOWUE+uwiiO+uAF5yziPwn0q6SrwnJGsJgNewsxnusQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSjcZZBeDFSIAmMDcu/X9GCea1yd+E+KR+MfdIRE2TNgZGens6
	3R3oWJgsyac9R5xi8YTDBJ0zF+pRe8mIpW0MfPg5ExZ+prdZAd0A8R7HtdJ5jcCiaKg=
X-Gm-Gg: ASbGncu0WRcl+SUdwK699XWIytMmofDz/9ymNw0LsVMrxkG9bWDfXXlSjHF7gc+dJJ/
	fv1wop9potcmfkP0Kv2eMsmbTKI7lcjWK7627Gc5+KfdHunvqs+685cr6B8IYfBfVu1qFOlth28
	yYHJYQDSooSm20UwgiK7hItARuYP6Baoyy7+KlTsLu3KniU9b4iZN4mbgnnO16trP85GxDlxWVx
	xdcjRd4NPi4HMhBQ497jO+rLT4vINKx5bD2t977mhpSp4I3un701/E9V9b6dzrBn7PVlIicABDy
	A19o6tlisG7gLzN+DaShnOmCgDEd3S0vYmQvJ4dF3GpWTQIECJN22P4kRR87sVQxqhWFcUjTF+0
	UBXLe2tH+/CMXd8P3ClKnHZ/niCgJZr7fYD3FUTFxIRsvjYOa2nASNmfclgCBhFcBjBuOzGATo5
	w2qOsBHjWMP1Pp1l0i
X-Google-Smtp-Source: AGHT+IF6JCuxEZc9y0QYtoe+lnLLK/6b+Owh6L1ix6z7q6TGMdRyMUdjp+zdpzoyT5DFMBxv/91G6Q==
X-Received: by 2002:a05:6000:2485:b0:426:f40a:7179 with SMTP id ffacd0b85a97d-42704d8f12emr14823720f8f.26.1761118614244;
        Wed, 22 Oct 2025 00:36:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427e1be5d6csm23610769f8f.0.2025.10.22.00.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:36:53 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:36:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: liubaolin <liubaolin12138@163.com>, anna@kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
Message-ID: <aPiJkhNJ4dgOlMIj@stanley.mountain>
References: <20251012083957.532330-1-liubaolin12138@163.com>
 <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
 <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
 <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
 <b928fe1b-77ba-4189-8f75-56106e9fac19@163.com>
 <ee0bb5eec4b43328749735150c5505f02e7a1842.camel@kernel.org>
 <aPiJIBTsQit5jyUg@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPiJIBTsQit5jyUg@stanley.mountain>

On Wed, Oct 22, 2025 at 10:34:56AM +0300, Dan Carpenter wrote:
> On Tue, Oct 21, 2025 at 11:15:21PM -0400, Trond Myklebust wrote:
> > On Wed, 2025-10-22 at 10:44 +0800, liubaolin wrote:
> > > > Sorry, I didn’t actually see any case where req->wb_head == NULL. 
> > > > I found this through a smatch warning that pointed out a potential
> > > > null pointer dereference. 
> > > > Instead of removing the NULL folio check, I prefer to keep it to
> > > > prevent this potential issue. Checking pointer validity before use
> > > > is a good practice. 
> > > > From a maintenance perspective, we can’t rule out the possibility
> > > > that future changes might introduce a req->wb_head == NULL case, so
> > > > I suggest keeping the NULL folio check.
> > > 
> > 
> > I think you need to look at how smatch works in these situations. It is
> > not looking at the call chain, but is rather looking at how the
> > function is structured.
> > Specifically, as I understand it, smatch looks at whether a test for a
> > NULL pointer exists, and whether it is placed before or after the
> > pointer is dereferenced. So it has nothing to say about whether the
> > check is needed; all it says is that *if* the check is needed, then it
> > should be placed differently.
> > Dan Carpenter, please correct me if my information above is outdated...
> 
> Yes.  That's the gist of it.
> 
> However Smatch can tell that the check is not needed then the warning
> won't be printed.

However IF Smatch...

Gar.

regards,
dan carpenter


