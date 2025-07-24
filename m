Return-Path: <linux-kernel+bounces-744768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E514B110A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD185A7AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E62EBBBB;
	Thu, 24 Jul 2025 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzA+lpBL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A961F872D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380466; cv=none; b=ipP2e+527JW9456/CTwWGumHPBWlDRQ39lqojWxLzCgMapN4KhlrPGfyR2aEWEkQdVuI+vNcUk16+UqQsiVtyD3PwzAt20nxJM6VjrBHOrz6kJB4tb9K0hehEv5+GJSx7H01bmxhcQM0YbUYtue4DnbmFV8DfqIPm7rAs9LZdno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380466; c=relaxed/simple;
	bh=/ozwSU1ZI3uE1HB/k5MkWlGV33qbqAXSYa5lqA+H54Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dvG2uMc7onruuBlxCsE7dRUZU4OtUjtt+kujlQUP9L9p7HZJgeBMcwHgX9m/KGtXzpta1cE9raufOLoehUmK/SIr2fo/CENviN0ankB7bf5gadhWjU8NwsijRXEPSg9iumXJS9vQ0Jp0HAbiFNLm1QfNAZvMCAWu4x3iLxuc4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzA+lpBL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753380463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ozwSU1ZI3uE1HB/k5MkWlGV33qbqAXSYa5lqA+H54Q=;
	b=hzA+lpBLqpiL9p/+nU24ueUEycrFeBRT71BAIpEQVJPpoTs0pejcpL8EwWsCD8qm2AFcZo
	QUEW0HSm12zu5Cg83qjkwEgvARCw+xnIy3HeyLD+DlumwcFjHEbgddI0o4AiXM+fVoRSwS
	lvj++KyfG2Ccl+cx+DdPOw77Ujud6Yo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-IyL9USvKMWWeu5mKaSXKmg-1; Thu, 24 Jul 2025 14:07:41 -0400
X-MC-Unique: IyL9USvKMWWeu5mKaSXKmg-1
X-Mimecast-MFC-AGG-ID: IyL9USvKMWWeu5mKaSXKmg_1753380461
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6076ad0b2f1so1217159a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753380461; x=1753985261;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ozwSU1ZI3uE1HB/k5MkWlGV33qbqAXSYa5lqA+H54Q=;
        b=LYOangNjLObI/g4z2IiUCglKrK3CH8z0FbUyOdLa1U2becb16iH33SvmXCgdd7tuMR
         aEa+onf/zrL46jbbX1GVyM/TKxjfVTjXPcXwc3OfB7ERzLtmzjbwinbc7SIV/353CIJz
         CZkYcn4qZUb6vkRxkjv82mev3PP96aEuHh1YEqkik5nUGxXQzUMsW2UjEMXbua4xhjsO
         Z7eo1OWbQF0Q3Y7M4WukeaqjEpaULWoD7Kow3cBF7BdX4bG+9y1bQh2Ow1UozrqVF1oz
         DpE1+pqwUs0Esuys17HWScucqmXezY1yzvZF2Ibbkvir3Byr7MQhcF4yH+Pxectslf2T
         IecQ==
X-Gm-Message-State: AOJu0YzzzKXhqqseWuSE044d5n6DNdrDUqbpAXouMnsuC+/vtzesWLHe
	pNXbVfYuK49GRDPcwsI6v3Y5ROqVB2iztoh/qa6m3niA53v8Fedulk8Sn4Fs7hM2NSUiIY4Rks1
	2CjNT0WrAJYz6vajnaQWnSQ9lPYFJekORHKZSSxo2X2g6B9hi5jzisBaxCgVPnro4GA==
X-Gm-Gg: ASbGncstWTjZYAUiV8qIB1Mt86wpGQ/sF62x2sZObUcsnxNchGMyTu3wKV2brwkrp+r
	jJ56C2hZauTOkpFAaKv8KnZMbMPemM/xiq1jonkW8y/UJf+TxEG86/qpDqnxOJM/7CA+/rFtCuU
	wj6L1A5ZzshElnKRqejFNeMNgHVOJd6SZQboGRz7Y9crEzk13gAq3oLxPLpP1DCbcdZADWmupsm
	vO9HtDS3ZqjJuuFJVfX3QAOiVuk1JUIuZmxrkZMprmDXbXBNdaIukA12w4GA4SDCEXJWMTv5HXp
	BWwV9P6p05PMbxJ+Xoabo9A0AHC44WuzNiV9Rw==
X-Received: by 2002:a50:8d5d:0:b0:612:b742:5bba with SMTP id 4fb4d7f45d1cf-6149b432c75mr5783402a12.13.1753380460483;
        Thu, 24 Jul 2025 11:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE76QhWk29P31Ec2HeV9qk7dkmNVdWUb47+aOH7CQ7cnHhVQHRrexd18nyyPH8c6UUTKWLfBA==
X-Received: by 2002:a50:8d5d:0:b0:612:b742:5bba with SMTP id 4fb4d7f45d1cf-6149b432c75mr5783396a12.13.1753380460066;
        Thu, 24 Jul 2025 11:07:40 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.134.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd319805sm1109971a12.49.2025.07.24.11.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:07:39 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:07:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Message-ID: <735d8530-f733-4973-8b0d-ac601d0a1799@redhat.com>
In-Reply-To: <20250724104011.7b4e11d9@batman.local.home>
References: <20250723161240.194860-1-gmonaco@redhat.com> <20250724104011.7b4e11d9@batman.local.home>
Subject: Re: [PATCH 0/5] tools/verification: Improvements to rv and rvgen
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <735d8530-f733-4973-8b0d-ac601d0a1799@redhat.com>

2025-07-24T14:40:23Z Steven Rostedt <rostedt@goodmis.org>:

> On Wed, 23 Jul 2025 18:12:35 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
>> This series introduces various improvements to the rv/rvgen tools as
>> first posted in [1]. It also adapts generated kernel files accordingly.
>>
> So keeping tools and kernel separate for RV is proving to be quite a
> pain as patch 4 has conflicts. I'm going to make a third topic branch
> just for RV. This will include anything in tools/verification and
> kernel/trace/rv. I'll restructure the patches I already added and move
> them into this branch, so that all the RV related work is there and not
> in the latency or tools branches.
>
> So no need to separate RV into kernel and tooling anymore.
>

Alright, but I guess going forward I'll try to keep changes separated anyway, if possible.

Right, 4 is problematic here, it should apply cleanly on next though, maybe I should have rebased on your tree instead..

So do I submit together 4,5 and the kernel ones? Or again all together?

Thanks,
Gabriele

> The topic branches I'll have is:
>
> tools - for things like rtla
> latency - for the latency tracers (osnoise, etc)
> rv - for the runtime verification work.


