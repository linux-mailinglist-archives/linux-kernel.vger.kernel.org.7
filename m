Return-Path: <linux-kernel+bounces-768663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40756B263DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4833A3C63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93F2EBBAC;
	Thu, 14 Aug 2025 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="g4tDQpLz"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE47CA6F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169650; cv=none; b=cSR9mYP7YaezQ00lphoV8Uljb+X6sxMp6IdcYf04TwBlGH083XUlZsvKp7v9Hqagy6mqp0BNRx8AAQAYQ/Aky9XmJuwpp2oV32bQEwome6GTx/QsxW+Hf950smUBypEs0k15qWmQaYk1Fim+zxmA0MWQ+QUtFDr+qYmsLRsYFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169650; c=relaxed/simple;
	bh=AkZGrxwMO+oMPfZktWEGKV69pL04SbvQa/zoDl7qgEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nLsKdD+k7n6RirYRi+wsl67AG3cXVZ62c76fn4YcSmRgWfrPIRp9cjs/80dOCTcPpsx7xHSQD8ZXWKqNz6I81k/p8v+pydCkXq0lcJ7Czz9WCjQRmjP2IQHlhaOV7HT1VjrmGXKZnz0bJcF878weKpWh72yGD5tUYsthdVU2Fwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=g4tDQpLz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9edf36838so452715f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1755169646; x=1755774446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhzC1LIt1LNTjS6++SEvIb6wixTsS4zRbZp52DT3w4U=;
        b=g4tDQpLzv+d7rwxVlXho/oZXnHaGK5hGbYLIqtUfXOf7xHTK5ZH8ULOMugOxW0BoL0
         oL9XkwgeF6atGF1iCLlD/M6OAkjb4ItQfF9v2cU8ILMAerXWrKyvkThCE6ucuzFCd42E
         t2yyBcV6hd9jNaam4oPynQwll44BZUyAyc7XN2Cnd/YrhGN0EXTW0o1OmuTfsqYOcrjk
         0BO0ilRfSYQSLvvjdBfxigmR3MXfRzef6LmXlScjmNGELRGzPYJceWd7fJR7q0Fs3MNf
         k6mgqqVdzN3oHjuHBrbck7eehcZfBAC0ZY1MpGoJnUV+3OByDXkOSN0kwqJNguZAe9Vh
         IHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755169646; x=1755774446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhzC1LIt1LNTjS6++SEvIb6wixTsS4zRbZp52DT3w4U=;
        b=TDGQidTopIPMQihHDUhKjdLeDr1njXeVL4GRy7jVYzxJ7Lx8VQzMrIpbmZ1G4LfSUP
         tqEQ46oMqkUk1dcqA5R+dhguuXW2L7RXQbQVJjXH+YDPs2RAVtL8KjSKGC7Ck464Yby2
         VeEArkHMQosADdpFsWO//Dc8iPFpuG1WoDDvGstuVLNT4ywV3zU021QbJgxbBt/YvovL
         LtMdtFN8xcpFRz3ICG+tjlj5DU6OuhI/uF9/AMpB4VudnaTIzFUqoOsEea/7Q1K+r3MV
         qvFLeI0wncP2qUKgUW+N9Yu87rIDSTLBVpoea8DpVHYyArNlVavx6YLQ7FL7Ha9zl1Z7
         nDng==
X-Forwarded-Encrypted: i=1; AJvYcCXoYJPNvQPZfhRqdYz53WJQGYRxREAx225K0eFypt+ur33OoCxtA8m/bRhioHW5qycVD20f/PlwHpFY9Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5At6DD7g0A4Fa+VbAs3jkdlWPU0jYyq70bdEH3FzErjNe6jcO
	vsm2p7KgoJ7qvK1OtjIlwKa6y5oC2vDknCIfOTfw2sRkWIHUSMOjAWXr1uXMdPtatfA=
X-Gm-Gg: ASbGncuT/b0nRiadWshWmqvWCA1lrtcja5ye9jr/dOQ2HDw7YltMuKsItML58OGvmQb
	3eXWk22ehNe4J3fTJQMEOajDGKSE+arHUyq2pDsTZAN59mxh0BmGeliVJUFE6//dFHCuUO7X+j3
	29K9P6xTPEUiJABwy+x3IS+PmQkfNSe+BNuhtsvN8H+DShj2WMhTkoUare7VD72/uPD+sWp2wNW
	UuanX1cwAr2pCrGA1LJVrH9PD/jmG41QzuhoPHfZQxQJJrn9A0BWWPDuCzLrxYELQ5bPkKKx60t
	MvC2DdXDLE3eFAVsw3PA/+lBTnKDxFNFsnaCv5TaXBO58RKeKDBuFwC6H1Ex4a56q5OrfWKvDhA
	IboeLs9ofxn0g5a9BCAKZeMV7UB9rrO6uGoVdzMn+z+J7TQ==
X-Google-Smtp-Source: AGHT+IG+WqGjfQftYWUvsowlRp0/lbM82rvGxjJZqJkNe/p0TTWmDn5ifF6edyehRMIL0CNuZ2dMUQ==
X-Received: by 2002:a05:6000:2887:b0:3b8:d15d:933e with SMTP id ffacd0b85a97d-3b9fc362529mr2344546f8f.56.1755169645890;
        Thu, 14 Aug 2025 04:07:25 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abec8sm52567672f8f.8.2025.08.14.04.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 04:07:25 -0700 (PDT)
Message-ID: <14ed323d-de4c-4f98-a16c-8bdb1b92c34d@ursulin.net>
Date: Thu, 14 Aug 2025 12:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Move the memset() function call after the
 return statement
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liao Yuanhong <liaoyuanhong@vivo.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250814093957.137397-1-liaoyuanhong@vivo.com>
 <d77e242e-af6c-4693-b207-576b823a0c0f@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <d77e242e-af6c-4693-b207-576b823a0c0f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/08/2025 11:11, Christian König wrote:
> On 14.08.25 11:39, Liao Yuanhong wrote:
>> Adjust the position of the memset() call to avoid unnecessary invocations.
> 
> Hui? That doesn't seem to make much sense to me.
> 
> We memset the local variable because we need to make sure that everything (including padding bytes) is zeroed out.
> 
> Even if that isn't sometimes necessary because of error handling we clearly shouldn't try to optimize this.

To interject with a curiousity, it is even worse to move the memset away 
from the declaration block when the often enabled 
CONFIG_INIT_STACK_ALL_ZERO is on. At least when they are close compiler 
can figure out it only needs to memset it once. Move them further apart 
and sometimes memset happens twice, yay.

Main point when CONFIG_INIT_STACK_ALL_ZERO is on, and it often is, there 
is no way to avoid the sometimes pointless init. I have some local 
branches which try to address the worst offenders but it is so much in 
the noise that I don't think I ever sent them out.

Regards,

Tvrtko

>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>> ---
>>   drivers/gpu/drm/radeon/atombios_crtc.c     |  8 ++++----
>>   drivers/gpu/drm/radeon/atombios_encoders.c | 20 ++++++++++----------
>>   2 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
>> index 9b3a3a9d60e2..0aae84f5e27c 100644
>> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
>> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
>> @@ -770,13 +770,13 @@ static void atombios_crtc_set_disp_eng_pll(struct radeon_device *rdev,
>>   	int index;
>>   	union set_pixel_clock args;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev,
>>   				   &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> @@ -832,12 +832,12 @@ static void atombios_crtc_program_pll(struct drm_crtc *crtc,
>>   	int index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>   	union set_pixel_clock args;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev,
>>   				   &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
>> index d1c5e471bdca..f706e21a3509 100644
>> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
>> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
>> @@ -492,11 +492,11 @@ atombios_dvo_setup(struct drm_encoder *encoder, int action)
>>   	int index = GetIndexIntoMasterTable(COMMAND, DVOEncoderControl);
>>   	uint8_t frev, crev;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	/* some R4xx chips have the wrong frev */
>>   	if (rdev->family <= CHIP_RV410)
>>   		frev = 1;
>> @@ -856,8 +856,6 @@ atombios_dig_encoder_setup2(struct drm_encoder *encoder, int action, int panel_m
>>   	if (dig->dig_encoder == -1)
>>   		return;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (ASIC_IS_DCE4(rdev))
>>   		index = GetIndexIntoMasterTable(COMMAND, DIGxEncoderControl);
>>   	else {
>> @@ -870,6 +868,8 @@ atombios_dig_encoder_setup2(struct drm_encoder *encoder, int action, int panel_m
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> @@ -1453,11 +1453,11 @@ atombios_external_encoder_setup(struct drm_encoder *encoder,
>>   			(radeon_connector->connector_object_id & OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
>>   	}
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		/* no params on frev 1 */
>> @@ -1853,11 +1853,11 @@ atombios_set_encoder_crtc_source(struct drm_encoder *encoder)
>>   	uint8_t frev, crev;
>>   	struct radeon_encoder_atom_dig *dig;
>>   
>> -	memset(&args, 0, sizeof(args));
>> -
>>   	if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   		return;
>>   
>> +	memset(&args, 0, sizeof(args));
>> +
>>   	switch (frev) {
>>   	case 1:
>>   		switch (crev) {
>> @@ -2284,11 +2284,11 @@ atombios_dac_load_detect(struct drm_encoder *encoder, struct drm_connector *conn
>>   		int index = GetIndexIntoMasterTable(COMMAND, DAC_LoadDetection);
>>   		uint8_t frev, crev;
>>   
>> -		memset(&args, 0, sizeof(args));
>> -
>>   		if (!atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev))
>>   			return false;
>>   
>> +		memset(&args, 0, sizeof(args));
>> +
>>   		args.sDacload.ucMisc = 0;
>>   
>>   		if ((radeon_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_DAC1) ||
> 


