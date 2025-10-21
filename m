Return-Path: <linux-kernel+bounces-862891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CFBF6766
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BADE63557FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC732E73D;
	Tue, 21 Oct 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5f5FCtJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639A32E741
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049942; cv=none; b=CKD1FU8G02z6/eSfJyeDXFlS3lvgyPnokJiLGtHLH0beR8k4ElDbaPuyI+3Q3tpnx9p4G03PbrIvGgWdPhK0rvTnemNDnC0KuxyxmsVUCrlywTSJWRWxjHLLhKuSlaLVopPsHz1R1/9LTekf/JediYFxrKAvbbWQUNYOBxkJrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049942; c=relaxed/simple;
	bh=ccp1VoQpjJs+I5YqP3Z87X9N7Yw3gj2MXIMQRc8Nclw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7iWgpiVsYiqZd8YKM8z4iLdQv5uHWhhfHamDEQBeZdUfItqMD7CcEGNCwaM+PmtZKzAPosXoIdM+QEHG90R5J6zDOgcS+dt6/1eV2DHgbkNZlEhHwBPb6AOFAs899KfkmqXWEx4JTO4eH3R39Q7IiAeYusq75xTY/0Lx/9Q1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5f5FCtJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snHXFbUKVcqPgriwKGeD9+p0jAafcLSmWXFrDke0XWU=;
	b=Q5f5FCtJJGGvLTlc5sBqaZpeBhHJfR9TXIEvFTOO9GXaKFCyVkd8bvlR3TTrQmi4TCfI9v
	qe7Cs24QAMvzSefti1RGLNeju19CLSkid8CfRcEnolbXNn1tzpBjm8kX+oNksmpyrOPAEz
	OPG5FrnQGqoOiL43egViHjcM9/WZvMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-QipAItZ2PhmEoAs2qV7qrA-1; Tue, 21 Oct 2025 08:32:18 -0400
X-MC-Unique: QipAItZ2PhmEoAs2qV7qrA-1
X-Mimecast-MFC-AGG-ID: QipAItZ2PhmEoAs2qV7qrA_1761049937
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee130237e1so2418534f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049937; x=1761654737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snHXFbUKVcqPgriwKGeD9+p0jAafcLSmWXFrDke0XWU=;
        b=DbMC8sMbJi4JJAnOwd3oAa/3Z5AApelwe57ALtQLlmlIBd+fZPxD8/08t1Yrq13P+s
         xC/FRocDwmqFtKOdO2LH81kj2b5da1/Lvd7RBgEO4Nl4eDGsOwuXKLcvgs+D0/Sz3sG4
         rnrkyLXkty+fKjHkhbMN8ukmNaeUkzA0DuikPwBgbQAErsS7KMNV70S0lxmY53+tjFwc
         dKvQmY+LFc29YztM0gBZPuu7O4xysnOYauZk5duzM7bsvzRLkY1XP4LQWe58rzMCP9gf
         mWFBWQdvEhACDcc/RGIshwqnmWCkLY12SOuqo2Vj36WBEY6r/lbE96oEuAfu22XgmumE
         tqvw==
X-Forwarded-Encrypted: i=1; AJvYcCWAX4P/u6smV4ko1MJUSnFlvR9pnQtZrJpi8/WaOpr/h4+VFHsF/xwoDGzaOHaz8hg/s1zTeUWIRrRvsCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1GQtE0LP5I1NLmbhjRa4iKLYOR3psjQTlVPAMgyVNfjWfPOb3
	BQnuJr6votpiwL2OWNriiHejMxPKCvRP1rH5lGlO5uyzI4XnJkX9OOQA3MFZuRUDWVBJr9qFrd2
	PUviQ3PW+QBAsDMuayxSa8U4XxIt1NH3blLf36mvDIPQMiXXUpoekdfPCFx76d6yLxw==
X-Gm-Gg: ASbGncv6YN2gN03bwGuLJEkY+ZytzAzK//25szpckbPxwPQBmgn0W9aNzUQloNF9Hc4
	MfF2B8Z1dBadEZaa077CUj5CCrVIFxi5l6xAIHWUlfwt3Yn6sCoaeZ7G+fexIpj0YTDAEECuYas
	NnTSoyf8dVsErProTdku3yEgAbK5rkrx4dhLfbh3hOjpl0Ro1boeIEsgcaulvhPaWlOayUnFXsV
	ZqD7Abo5XHMLJFuOUsbnGqJtzEXXKenjKJOTsTrmf+9NLYoA+QzaqqKdYKI1me3iC+p0pDnCeW3
	Cie2ATkn+KfbtMO3Rj81rpg6X1eTr3UBrRvWLXV2jYc4iXvtkjExJkMsV8ycMzjkUcr+LrW2uh7
	0eq4+TeZtp0O08sx8kfTKfoYa3FdHiZOJhpDdp2M=
X-Received: by 2002:a05:6000:2305:b0:427:928:7888 with SMTP id ffacd0b85a97d-42709287b06mr8917170f8f.55.1761049936852;
        Tue, 21 Oct 2025 05:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBU6pyNtgJdNbG8KrDXp4BEjrSCFEszvqCmaWd2PrAFmOwM+9q033VKMpwkTA1TH8Zuz1XMA==
X-Received: by 2002:a05:6000:2305:b0:427:928:7888 with SMTP id ffacd0b85a97d-42709287b06mr8917142f8f.55.1761049936420;
        Tue, 21 Oct 2025 05:32:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce586sm20603530f8f.49.2025.10.21.05.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:32:16 -0700 (PDT)
Message-ID: <2819877d-610f-42cf-9b3c-ee2d836e2df0@redhat.com>
Date: Tue, 21 Oct 2025 14:32:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm/panic: Fixes found with kunit.
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <f8f1e0ec-46fe-4d71-94aa-bdd081ec35fb@redhat.com>
 <13bc66cd-a63b-44b9-92fb-98b5b36ce2dd@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <13bc66cd-a63b-44b9-92fb-98b5b36ce2dd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2025 13:24, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.10.25 um 11:35 schrieb Jocelyn Falempe:
>> On 09/10/2025 14:24, Jocelyn Falempe wrote:
>>> A few fixes for drm panic, that I found when writing unit tests with 
>>> kunit.
>>
>> Pushed to drm-misc-fixes.
> 
> There are many patches without Fixes tag here. Commits in -fixes should 
> preferably have a Fixes tag to help with backporting. No need to revert, 
> but something to keep in mind for next time.

Ok, sorry for that. I'll add it next time.

Best regards,

-- 

Jocelyn>
> Best regards
> Thomas
> 
>>
>> Thanks Javier for your reviews.
>>
>>>
>>> Jocelyn Falempe (6):
>>>    drm/panic: Fix drawing the logo on a small narrow screen
>>>    drm/panic: Fix overlap between qr code and logo
>>>    drm/panic: Fix qr_code, ensure vmargin is positive
>>>    drm/panic: Fix kmsg text drawing rectangle
>>>    drm/panic: Fix divide by 0 if the screen width < font width
>>>    drm/panic: Fix 24bit pixel crossing page boundaries
>>>
>>>   drivers/gpu/drm/drm_panic.c | 60 +++++++++++++++++++++++++++++++++----
>>>   1 file changed, 54 insertions(+), 6 deletions(-)
>>>
>>>
>>> base-commit: e4bea919584ff292c9156cf7d641a2ab3cbe27b0
>>
> 


