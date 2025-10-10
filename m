Return-Path: <linux-kernel+bounces-848042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A50BCC55A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04295353FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3A26A0D0;
	Fri, 10 Oct 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjN0SNAp"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944631DF75C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088308; cv=none; b=GPDKJE8EUNISPPshQfurncjNONiSb5t2/3kUM+TDAmDW2pfWvgZS3Jq242wbu1qMuYYc3CE60feCGtAJx3fJpYcA+noAXKnq5b74VFUqRrbFk3xp/R/98aNT+Awfi20q7W6+ZSKMI6NdY4rp1UH95kjbaottsq+NRlH7ssaIbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088308; c=relaxed/simple;
	bh=+tdvnVe2e8mT0IutGfRanGBEmanMrI6O7sUZguwxdj8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5UbZTao8v+++Y/RrFp59BU9qIlojc5gUXdBQnKHls+9+Av217cYtW04JxLcjDlW4dqgNeV/Mb23vwh/mpm5Qp5M2uGgTd3410AaNh0ozy2sl0XSx49m1cBu9NIqTmPcT8j1PfI9xhahOw7nPfOOHMHmPTTzMD0E1HaZjcREBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjN0SNAp; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so1837485e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760088305; x=1760693105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNpPl6hAXjayQMYIPca/DuOFE/gtGVKCwiuLHkvOdLY=;
        b=NjN0SNAp94EiHcaYTPYu7Dw41jQf0Q6sh3oy1fYqIh+aQcInex9A9uRYXu2idewvyv
         oARpe8wlcye3w3/JYm+2yY0M8j/PWZp+7Ytm7PKtcoMiaJLL3xYEAVX7XADAN3oowCwA
         ZMdHEf1SsNO/RZVQhg+r3Haec4yXqqxzDSmR7806ptyqSqIPodHHGaHFOSGR7TocXdBP
         EbZdU6pPKIk+2Uc43a3Tgde8HGWM3cUrZWfjDHf0lzxbSulLJ9qqJKN1j0lE6OMVm5Yo
         BkhBRCQyP94so2qrgONd1+w4i/y/FHeGVHT+pDwV9PZbiuXohOvg80UsuYE/zgZ4DrFz
         QojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088305; x=1760693105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNpPl6hAXjayQMYIPca/DuOFE/gtGVKCwiuLHkvOdLY=;
        b=DlCDrXCoAPAEDzXHWYz9CkAI0PbMKzMnNritQKt/4ZNfC9L+KGGDKhOIvUd6zGUrzX
         TXaGvkA1PW+npVfKpbjMcUv5pZn3AOST37e5iZmiX5a2fzGS+zjkvgp/K1VUIil2LjK2
         mtFUZZosDUqySuWT4NOd4D89Jthf1jK4LoOE/DDurN7AgDW00/bvZg3eBUT6RaVOeosF
         XhEEI73WKJfQknCXUFiUVNu/EHXurYCkf5mVe8JmyynlmjdYYyycmy1vG5rYeXayEQTy
         asTELxZ/RGZTAFeLVdShbXwnMqNw9D5mRD2uBApHDPgon5hK54p882fLJnInXJib2lxQ
         O1dg==
X-Forwarded-Encrypted: i=1; AJvYcCVTqcBXvf54uW+OQ3xhvadrN1xaAogGXHb3/8ov/pWtGW1LK7l37q0mE85Z50NarSd0wUaTV5YqbltRT1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfP7rGnMFkhQMT5auusm/VyENORHMIhozGfnni/Rd6KDl++jjF
	YWbw+DLzJ52vq8XZdlr0p6p/RUxdDdDqe/UDWKboiPLQvkJ9bVd9jtAnQ01L8MQg9Y4=
X-Gm-Gg: ASbGncu64g5YKkEHVdroeLagKhg3KyIjGfk14zxzyLtfQGkMMEGmQF5t5L+V7UaltRG
	1/dGJ9JBn3hqQ7WYdUh6AXBZW8Gpt19peBeI39UzGUBkLHVnNgHqu8aQ/hTPYGIdoE9Q+zLoKBI
	J9vsX0hxueIHDIgAT/saNeFRKSLHfyfiIaCFm18p7Ll6+ZsvKTRQBd/psnaOAZmlHnCRD38Wky7
	o30iViPqJs+no0URlPvQK1jK7iVFdZ8FLhfjbpQnN6u5yML8C1Hoqj9QHO5kZQ1GnfiYw3WsB2s
	VnhUvTlXWV/Cr4HjQ8HPDs6K3glw6Ez7oRDTAQiLuVENmB/YsjYeQ+gMCL1GKyhwG25g62wsf5A
	YqOny1EZ4
X-Google-Smtp-Source: AGHT+IGVEYp5cHpEK2FO80mr2HCcMtcTHSrsdr/ANPZCQq8+pyqO2qqAVh48IsjX5ZCSYu++mk97lw==
X-Received: by 2002:a05:6512:159c:b0:55b:8afb:e644 with SMTP id 2adb3069b0e04-5906dd6fb34mr3293174e87.31.1760088304586;
        Fri, 10 Oct 2025 02:25:04 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856d267sm696148e87.85.2025.10.10.02.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:25:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 10 Oct 2025 11:25:02 +0200
To: Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>, akpm@linux-foundation.org,
	urezki@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	ying.huang@linux.alibaba.com
Subject: Re: [PATCH v4] mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE
 aligned
Message-ID: <aOjQ7qDy3l85dn7A@milan>
References: <20251010014311.1689-1-yadong.qi@linux.alibaba.com>
 <13c257c7-1ff8-43b4-825b-03a3ceb32e96@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c257c7-1ff8-43b4-825b-03a3ceb32e96@arm.com>

On Fri, Oct 10, 2025 at 11:16:27AM +0530, Dev Jain wrote:
> 
> On 10/10/25 7:13 am, Yadong Qi wrote:
> > In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> > mapping size is aligned to PAGE_SIZE. If this assumption is
> > violated, the loop will become infinite because the termination
> > condition (`addr != end`) will never be met. This can lead to
> > overwriting other VA ranges and/or random pages physically follow
> > the page table.
> > 
> > It's the caller's responsibility to ensure that the mapping size
> > is aligned to PAGE_SIZE. However, the memory corruption is hard
> > to root cause. To identify the programming error in the caller
> > easier, check whether the mapping size is PAGE_SIZE aligned with
> > WARN_ON_ONCE().
> > 
> > Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> > Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> > ---
> 
> This should work.
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
LGTM,

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

