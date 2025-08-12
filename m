Return-Path: <linux-kernel+bounces-764435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6BBB222D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8D934E3A49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5492E92BA;
	Tue, 12 Aug 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yY9BAJk5"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B792E1C53
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990447; cv=none; b=lktuq0FQiLwmv8HbIhAOVYsT8pPiz9GChcbKel11rxm68ynFe1tAVi7rfq7B6FkQ7ONokEb/sqJNDfpoDuKdgFQYcvqCpjchSH9K29TkBTmGvZWVvcXYqQGinA/p5WS2RZRgfAawftBteTmdNumvFq69wO3ucmtKh8FW5TGsflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990447; c=relaxed/simple;
	bh=VlyJRw6fjn+cGBFDjG2vyIh5vFz+jjEif6UAkbsfgRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaW1KOrvPh4wWtWJqNIoQ4mhpkTdS6Lw0lqrYzjyzC0bGka5WQSOD9nDBNeedAskcxr5+mSJtdD5IUrOzWpnKyQFM4dEpnudt7QgxQTZCGCo0aJG16efQNyY6yv5sdg4OPcLzy6i+hnCbL3zCeTUEvGArj7AovqtTPHVE3aMAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yY9BAJk5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b780bdda21so4306519f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754990444; x=1755595244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flLwVRQBtS9lSLzZddc/x+DXeymZfEUE4F/7WVbfGqA=;
        b=yY9BAJk5S3cpuIAxclrrVj4pIGbXxhEc7EXc6eum6dRFeY7HGePyQQzY1P0KWYDAMl
         v/I3Va7L2TQEp5JX2q1otT7EF0xnW0jqU/Z3YgW6OWlNYTIo6lFnb23Z1kDqFFlkvBnE
         25Z79sHfkPjOKO9AnbgoyuuBbwbqr9yqt/eqpBddzkdY32HyAJPTcuf+m4rjZKahyTXQ
         WQK3Br11KxjCSivdjOTD3fX1FvDU5gIJGSU+jkDMF1jKz69uYLvxIQvTJzwfXlzXMdCy
         Mx3/hXpNpp7GNtefVBQSaVpT4kMjrNlE6KQGpV6b9CqSEiE6ssEPgSLcZTFd1Q0iIMJp
         /uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990444; x=1755595244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flLwVRQBtS9lSLzZddc/x+DXeymZfEUE4F/7WVbfGqA=;
        b=kLRWnAZejPY7Dz1aAUAW8PJzCyAw8noAsL4Mu/6mxLUzL2N3ueMMg5itCMMsUsTj2Z
         OAMdqsEppVks3JFKQGG8EhK+1TMWG7oubBmAliK+6vQ+w9Hxif6hmi2q82gXiCzUC+Zu
         R7hc8sJgYx3xNARsj7hTTXfSfbGND+eVzmte/cvroFUFQv46I7e4LH8agz/0OwJ7Bzvm
         /afqJ0bHFn2wPNMhbP9jeu2L3dgcgWORf5Oz5Kue9pqPmPW/zRa1qpDQBILWxRcK2uOM
         QNZ8qZzUnKf8PcllLzKlZEB8iq/ivfGvRgKPz8DeSGbh965dSUmVzWXEE+DnVLKJmiHR
         n1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcxf9Otrd97IWss+o2XdAkp5J2/9qaAIN4HW94venBIjQYwlcxxe2S9RWw47LKadS53LsawbqRQrCx6Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47e0zVkPqmy7UL3q3Iw2q8TYoMvy0IqjLov0367gU12nQQzm9
	m4Z6YGrYGo3PMJFyByA+16cbkkXh+eb+KTJizHuSBo2Hb4dAjjfB9+IX81fiwCdItvY=
X-Gm-Gg: ASbGncsRQFedHqYM0Wyc94MpjgAK2Ogf1rA6jomNxVDXpHQP75Uszt9kdLbAD7r/DJM
	JEfCwYKooGB7o/O1OLiCTVIl75/sdV248f0nMPRXCApfhT4wkPAS6VHqJWQyyfOwBvpM4fnKyVg
	0uPPG0MKPPLMHge36sVvBMvRmdr+EXb1CHPxgWAjVvQb6PJ59Jav/3LhKsvUl7KdR2pmxJhTizl
	FLBlww0zIPpoLCLAZohJEG78YUL6d5Hdzpi05ku2uU2C60eLMxZ/zypIMbtebb/wjWJnTXPwcON
	F2B8IaeH3PHNiNFW0yz9odtzohcAslAJViMGu4PIs47piUQSf46C9b2IfttD/kcXA7ZCkIGaAsB
	Wkl5v0/o5p0khaLdhMFPHX9x3mUg=
X-Google-Smtp-Source: AGHT+IFrIo9/UNEvyO7O0y53JZzndWiEpzx55oxCbBR3AWHX7mjJt83BXH44/bTtMAxbhFy/v2lNzg==
X-Received: by 2002:a05:6000:401e:b0:3b8:d138:41d3 with SMTP id ffacd0b85a97d-3b900b8101emr12499799f8f.56.1754990444236;
        Tue, 12 Aug 2025 02:20:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453328sm45866511f8f.46.2025.08.12.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:20:43 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:20:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Scott Guo <scott_gzh@163.com>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Scott Guo <scottzhguo@tencent.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: squashfs: Avoid mem leak in squashfs_fill_super
Message-ID: <aJsHZmHN2I712xX3@stanley.mountain>
References: <20250811061921.3807353-1-scott_gzh@163.com>
 <24759bdb-b427-47a7-b9c3-724a11d0162e@web.de>
 <461ae944-5fb9-4860-81c1-1ac48c3d888f@163.com>
 <aJr43n1np2nB8bht@stanley.mountain>
 <dceb4471-82d9-48f0-94dc-e9277eadeada@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dceb4471-82d9-48f0-94dc-e9277eadeada@web.de>

On Tue, Aug 12, 2025 at 10:38:59AM +0200, Markus Elfring wrote:
> > Please, don't introduce more of those e_inval, e_nomem labels.
> 
> Would you find any other label identifiers more helpful for sharing
> error code assignments according to better exception handling?

Just assign "err = -EINVAL" before the goto everyone else does.

The common kernel error handling style is called an "unwind ladder".
Assigning the error code is not part of the unwind process and it
messes up the top rung of the unwind ladder.

//=================== Good =============================
	return 0;

err_free_thing:
	free(thing);
	return ret;

//=================== Bad ==============================
	return 0;

e_inval:
        ret = -EINVAL;
        free(something);
        return ret;

Now imagine you need to add a new free:

//=================== Good =============================
	return 0;

err_free_other_thing:
	free(other_thing);
err_free_thing:
	free(thing);
	return ret;

//=================== Bad ==============================
	return 0;

e_inval:
	ret = -EINVAL;
	goto fail;
free_other_thing:
	free(other_thing);
fail:
	free(something);
	return ret;

Also, in places which basically hardcode -EINVAL into of the unwind, then
it's pretty common for later updates to carry on returning -EINVAL even
when it's the wrong error code.

regards,
dan carpenter

