Return-Path: <linux-kernel+bounces-794221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 628CAB3DE92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6306C1A81647
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E330DD0F;
	Mon,  1 Sep 2025 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+mTvftj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C12FB986
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718984; cv=none; b=RZgcm6OKzoxwUqTF+HIemq+EAUqclZ85aS7G3ELt3rzNxk/REzgWVGSAgQs1zhMFKhcDoB87BTZ/NwmiuhLZp0HbG00fs+HUUuPs0ms9/zA2QJDM4i6BMKLNHPa1cix/Nfbci1aMdukOCFwZTNkycHJHlR7SIcLIXRNfaRI5b0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718984; c=relaxed/simple;
	bh=+77LpAQwApfrcXf+koZH/J0LGzOh+hJKuVFMuxmXuMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EoZMUTs0ENUsC/a6cPZHYaHheSYsb4Srs2viKpK3ZvScP7Df5v5gHjGc5ZXaSuLafI8Qhg9mU4ZI/AebRdBEw8r4BJoxkiblV7Fl6qBg9PWVxy36IC7/RsepbljvtAO3zfkScdLxo8cFB8sdrd06adKjl/mGqfi8RkhkwG8GNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+mTvftj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756718978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLIfWutU/YiglT+ISVkDDOc433nVPWRihDwo9lIf2vg=;
	b=Q+mTvftjPt2UBB3eYmjserIqr5N0eZVngI7XZBoWAONT/Hnt008KGmjrAbReHMUe4Y2oGC
	SSidZanwX5dHfWciml5vtXTwsOuKXB2stmAi/jTreajqLpJDmSzVGxoVWhhZAedL+PVr84
	T8lTJR+Z0LPOUR67zXDcZWIrm4vx9gQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-nXgmFWaFM_-dlv8kqiFsvA-1; Mon, 01 Sep 2025 05:29:37 -0400
X-MC-Unique: nXgmFWaFM_-dlv8kqiFsvA-1
X-Mimecast-MFC-AGG-ID: nXgmFWaFM_-dlv8kqiFsvA_1756718976
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b869d3572so4245525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718976; x=1757323776;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLIfWutU/YiglT+ISVkDDOc433nVPWRihDwo9lIf2vg=;
        b=b/ePFbWsg0+wV8UPLA2u0knfGr5Jp9pcc4lNpsUGAsNJaE1zRghcpv8axMOp8wjNsN
         lHba3taTRa5gLj/3IClTPlqXSGm1AFLJANThMxxMwUuM52fhcfJNtKtjqAYWyaR4Yhrj
         EtX7PkpZsxl8M8xXx4D++RceGgfo+2wEKsGkXe+RrfU2f/L7BVJhgaGO4lFTOrfDpUln
         i7uWFzevqHNQg122PBaR3er31/8PZ9qFHfkeKZx3tGB0/B62G/Dxoaz0maYeNB8//RJ4
         yE3tBn2YkJphJrjpsbuFJ6dSWA8j51cIRO7mFTbarFvVirgnIPXJlrPujJD6XDqM6QIw
         ZJSQ==
X-Gm-Message-State: AOJu0Yzs7JHX48nLX/2fIhGTi2LlJ/I+oKYSdY1/W+BsnMr8b6r1Vj/6
	9zzog7Hzx31NhNqXtFUQSLzFJGqW+VQBHDLL46pfEUISz0IlN0TmVWt4Cana48KTxKw7Z79J9q3
	aco3vkAelOGmKab1Vxa1xRWNmyOsG3K8pfICxPpiEGbrV/0opCl2NrlKlfXJoKZFIbA==
X-Gm-Gg: ASbGncvthypIdwwvCXbCdTonBHlPyJwXoCDEKAdefE8TzEipWhnGmdl/sbc8bYh61hK
	0KEp+NfLNYPVmZMXHn+38qXoqsy9q2AmregUdX63ECvMnZdD296Az+KuEC+92QFWwY3waCAEjip
	Ly0Y6nFIluI4qP5cZSTmUKhyHeqXIZy1/Qn2E92VdlsIjgGS2LfsnIZntmh3M9OybLqz1S9Owaf
	0/H4HzZpiJq2pzuaMIH8rpMDmjhh4nbRiLMkC7hdKpOhGMPTNi5WF7ym4tX+dpT3BJunTJsOxDQ
	ToHkHi4eUv+KNdR0ojwW9NJHVJtzJVEIrMYNgu/G9DF5/bFQZOzzbIYsqLlNWUCFhA==
X-Received: by 2002:a05:600c:1d07:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45b8553417fmr73118815e9.16.1756718976027;
        Mon, 01 Sep 2025 02:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv92lhrsAt3OXKOOSRcUvb13YtIbGD8LLn3o0PT6k8/S7ZFs5axHkJaP2LWNR34AeeM9XjJw==
X-Received: by 2002:a05:600c:1d07:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45b8553417fmr73118475e9.16.1756718975616;
        Mon, 01 Sep 2025 02:29:35 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73cf86f4sm207079325e9.6.2025.09.01.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:29:34 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, David
 Airlie <airlied@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Maxime Ripard <mripard@kernel.org>, Simona
 Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/sitronix/st7571-i2c: Make st7571_panel_data
 variables static const
In-Reply-To: <w4tlpcw6s6yogacneo4gthor5annn3qjyxswrtrisoqawdbf3p@y5r7gkrmzmdo>
References: <20250718152534.729770-1-javierm@redhat.com>
 <w4tlpcw6s6yogacneo4gthor5annn3qjyxswrtrisoqawdbf3p@y5r7gkrmzmdo>
Date: Mon, 01 Sep 2025 11:29:33 +0200
Message-ID: <874itmv7uq.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> writes:

> On Fri, Jul 18, 2025 at 05:25:25PM +0200, Javier Martinez Canillas wrote:
>> The kernel test robot reported that sparse gives the following warnings:
>> 
>> make C=2 M=drivers/gpu/drm/sitronix/
>>   CC [M]  st7571-i2c.o
>>   CHECK   st7571-i2c.c
>> st7571-i2c.c:1027:26: warning: symbol 'st7567_config' was not declared. Should it be static?
>> st7571-i2c.c:1039:26: warning: symbol 'st7571_config' was not declared. Should it be static?
>>   MODPOST Module.symvers
>>   LD [M]  st7571-i2c.ko
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202507180503.nfyD9uRv-lkp@intel.com
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>> Changes in v2:
>> - Also make the st7571_panel_data variables to be const (Thomas Zimmermann).
>> 
>>  drivers/gpu/drm/sitronix/st7571-i2c.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


