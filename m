Return-Path: <linux-kernel+bounces-768754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E823B2650D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AEC2A3B67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833592FCBE1;
	Thu, 14 Aug 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="aXCG42+O"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331A2FC89C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173409; cv=none; b=Pa1zuY5sa9v6tsMqN421Uw1nI+U8ofUs+raEkGRyVhaJ3DMnqxRfRboOGvKIMrq7kcoftMF8PObc31zAJM1L/zqxRGdVzjIBpcrRNeirxqRShxLv4QPnd+v/Ec+f0rH2fQXmC+1XvR6I2TlQLhjbnnpueNgfJyRZwd/os8Wdokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173409; c=relaxed/simple;
	bh=PSBT8akZhdFr2RiYlOnDowzUARNhzzKS83QM/onFS7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMNw0ow1wpyLIYKqTjkbKU1boqVKsp5aizkekkGV9fXQW6ZOMW8RzS5lcEQ626Q3AzmREFKh5JA4rQWNiW9An5GPwfRMtjo0blRGOfEhY8RiQvT2VRhc25AmiO/7NqK3mB5IQc6aVDJ2dEDFXYVoC065Zf/vuBz/iSZFEs8XrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=aXCG42+O; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0b6ac4so4151465e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1755173405; x=1755778205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMfECu090Asn46qOQ2dw2oUBhAroiHJn3Pg+69ai6I8=;
        b=aXCG42+OMsLFTD/PGGCvB2S67S9vV/ShqmQBxgow1Lp0G+uSp58GrWWEinCBrHDe/u
         o8rp4SdrvTN3J4IAJeREyP55l/d3ydsIlizwMP3mrCO8T4eTNKFplCEZbo/6whm2dfx6
         nCr6+CR1mj3wHx0jquCN6L/qz5vCXgWJaXq/a00KGHdzr1GHLvxllmDvUX5Z4C1d7f1p
         /doV4w3+dgCzIgs9Eq9d/Anw/L9IiuCyS+es3zXyIYY1wWwdSjGrVlbfTvD/L65gRe0N
         zw+ucm5uCLkPXxfet/RP8Mts88BtBUn4w2I7Y0E+yB1MWh/Z4jla6wLFwmUv+OlTdsZy
         UtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755173405; x=1755778205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMfECu090Asn46qOQ2dw2oUBhAroiHJn3Pg+69ai6I8=;
        b=Ea1klQdt/4GO1y3n46qmiZfvlgZIjM741OlIlTKnhV8mBRFrdBuLwqBoL6pNdiBxP1
         XEYS6HqoUNNU7VjRtEoMDYml0Ka4MwL8fAgd9gdgz7VK4Cf//ewFjLdpMX9pa9rs3rvl
         topMSO1MTmNs/ePq5HgywBIIidd27K/abxWiFPhYJYNtgKRRQcxYN9A3VTXA2lWJakIX
         XwvdYC8CvAQqzudBKZk0q3m8Px45VMXEBOcEF+OJAFHLUl6mJqjWhMMdvZixrndkCAv9
         udHhA2iY+rsUX0mVzcK+InO0SMDQkxD3E5QQDzdhHagoteBCPtZm4xQ1B4+5QkOR5IQ/
         9sZg==
X-Forwarded-Encrypted: i=1; AJvYcCWXyVfHZjMOiQoJl4yPsrJh2cJNn9xmECXTDTy8u9ARVN3Culr3rDdKa2mgmT6yFCKk/+JlOl4nInKkT64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNDis4jLTe10CEn6aAh0AuTxa/9GyGi+01tN5NA/ZWns46+Sf
	L6YgA/vd2nRGoX8m/HGO1LUdEXlAVv3aaIIwzqALmxuV32/Cad9qUeiUQ8Dw2i9mLMQ=
X-Gm-Gg: ASbGncs2796+VVWTJYiP1eUUuEeVgsitNZJZZm6o9mdlAgeRUJ+AHogj1Gfy8sjzTPf
	MKtdVyiGAaBHmXAdn9aGejS+uUShEYkbX3YqCoq7Kc/qhB77ZTG8+kydEXDw1rLXndH/xXy7Awd
	k7Ds0c8DXhO6RePwZ26cLUkYgvHvsY+70eaC/ApmytquwwrDwjvGoOhk7Z5OWdM39qPgglQIT82
	/An9Tdebjoj4MVHGnSKIER6UrjCJE5VoZO4ytZVMeuOvt6xTi0BdAEKG37aZdknW0mgJFutWH87
	i/PubumXZsY/nMXJ3rI2cAYB43bfdC5NrO/H9rXAj6Cyk4Hu6ThgyEVFEA+fY77V+Haj2mqD2+a
	1OXhlqpX/LJV8FD96tjkV/YahZdhvmfhY0lcqn+heDHQVUA==
X-Google-Smtp-Source: AGHT+IG+yZlmNZm+tYodYzm9SENbA0HuEUq5BXpzMK/In9ImWIQo9CrfZVmScyOift/+Mqu/LZUnXg==
X-Received: by 2002:a05:600c:3596:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-45a1b60f9a3mr21155785e9.11.1755173403395;
        Thu, 14 Aug 2025 05:10:03 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b91b05b28fsm4433541f8f.21.2025.08.14.05.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:10:03 -0700 (PDT)
Message-ID: <f1b5499f-1c7c-4a40-b986-74a014897148@ursulin.net>
Date: Thu, 14 Aug 2025 13:10:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Move the memset() function call after the
 return statement
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250814093957.137397-1-liaoyuanhong@vivo.com>
 <d77e242e-af6c-4693-b207-576b823a0c0f@amd.com>
 <14ed323d-de4c-4f98-a16c-8bdb1b92c34d@ursulin.net>
 <6ef5e1e8-3868-46c0-a31b-505f8a91d37a@vivo.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <6ef5e1e8-3868-46c0-a31b-505f8a91d37a@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/08/2025 12:56, Liao Yuanhong wrote:
> On 8/14/2025 7:07 PM, Tvrtko Ursulin wrote:
> 
>>
>> On 14/08/2025 11:11, Christian König wrote:
>>> On 14.08.25 11:39, Liao Yuanhong wrote:
>>>> Adjust the position of the memset() call to avoid unnecessary 
>>>> invocations.
>>>
>>> Hui? That doesn't seem to make much sense to me.
>>>
>>> We memset the local variable because we need to make sure that 
>>> everything (including padding bytes) is zeroed out.
>>>
>>> Even if that isn't sometimes necessary because of error handling we 
>>> clearly shouldn't try to optimize this.
>>
>> To interject with a curiousity, it is even worse to move the memset 
>> away from the declaration block when the often enabled 
>> CONFIG_INIT_STACK_ALL_ZERO is on. At least when they are close 
>> compiler can figure out it only needs to memset it once. Move them 
>> further apart and sometimes memset happens twice, yay.
>>
>> Main point when CONFIG_INIT_STACK_ALL_ZERO is on, and it often is, 
>> there is no way to avoid the sometimes pointless init. I have some 
>> local branches which try to address the worst offenders but it is so 
>> much in the noise that I don't think I ever sent them out.
>>
>> Regards,
>>
>> Tvrtko
>>
> If we converts memset() to = { },can it alleviate the problem?

Yes, for example I have this patch:

commit c780f63e20cb0fd66d31f3c1a37b37983a30f318 (240813-amd-csmemst)
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date:   Wed Jul 17 08:28:56 2024 +0100

     drm/amdgpu: Remove hidden double memset from amdgpu_vm_pt_clear()

     When CONFIG_INIT_STACK_ALL_ZERO is set and so 
-ftrivial-auto-var-init=zero
     compiler option active, compiler fails to notice that later in
     amdgpu_vm_pt_clear() there  is a second memset to clear the same on 
stack
     struct amdgpu_vm_update_params.

     If we replace this memset with an explicit automatic variable 
initializer,
     compiler can then see it and avoid clearing this struct twice.

     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e39d6e7643bf..ecdc8fffe941 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -361,7 +361,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, 
struct amdgpu_vm *vm,
  {
         unsigned int level = adev->vm_manager.root_level;
         struct ttm_operation_ctx ctx = { true, false };
-       struct amdgpu_vm_update_params params;
+       struct amdgpu_vm_update_params params = { };
         struct amdgpu_bo *ancestor = &vmbo->bo;
         unsigned int entries;
         struct amdgpu_bo *bo = &vmbo->bo;
@@ -398,7 +398,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, 
struct amdgpu_vm *vm,
         if (r)
                 goto exit;

-       memset(&params, 0, sizeof(params));
         params.adev = adev;
         params.vm = vm;
         params.immediate = immediate;

Or a bit uglier, different approach, but more on fast path:

commit 31c9f97d69dcc455fe45eb297bcb06c2b87d8204
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date:   Wed Jul 17 08:28:45 2024 +0100

     drm/amdgpu: Remove hidden double memset from amdgpu_cs_ioctl()

     When CONFIG_INIT_STACK_ALL_ZERO is set and so 
-ftrivial-auto-var-init=zero
     compiler option active, compiler fails to notice that inside
     amdgpu_cs_parser_init() there is a second memset to clear the same on
     stack struct amdgpu_cs_parser.

     If we pull this memset one level out, into the amdgpu_cs_ioctl(), 
compiler
     can then see it and avoid clearing this struct twice.

     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9aa952f258cf..554289eb1913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -51,7 +51,6 @@ static int amdgpu_cs_parser_init(struct 
amdgpu_cs_parser *p,
         if (cs->in.num_chunks == 0)
                 return -EINVAL;

-       memset(p, 0, sizeof(*p));
         p->adev = adev;
         p->filp = filp;

@@ -1411,6 +1410,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void 
*data, struct drm_file *filp)
         if (!adev->accel_working)
                 return -EBUSY;

+       memset(&parser, 0, sizeof(parser));
         r = amdgpu_cs_parser_init(&parser, adev, filp, data);
         if (r) {
                 DRM_ERROR_RATELIMITED("Failed to initialize parser 
%d!\n", r);

Regards,

Tvrtko

> 
> 
> Thanks,
> 
> Liao
> 
>>>> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>>>> ---
>>>>   drivers/gpu/drm/radeon/atombios_crtc.c     |  8 ++++----
>>>>   drivers/gpu/drm/radeon/atombios_encoders.c | 20 ++++++++++----------
>>>>   2 files changed, 14 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/ 
>>>> drm/radeon/atombios_crtc.c
>>>> index 9b3a3a9d60e2..0aae84f5e27c 100644
>>>> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> @@ -770,13 +770,13 @@ static void 
>>>> atombios_crtc_set_disp_eng_pll(struct radeon_device *rdev,
>>>>       int index;
>>>>       union set_pixel_clock args;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev,
>>>>                      &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> @@ -832,12 +832,12 @@ static void atombios_crtc_program_pll(struct 
>>>> drm_crtc *crtc,
>>>>       int index = GetIndexIntoMasterTable(COMMAND, SetPixelClock);
>>>>       union set_pixel_clock args;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev,
>>>>                      &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/ 
>>>> gpu/drm/radeon/atombios_encoders.c
>>>> index d1c5e471bdca..f706e21a3509 100644
>>>> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
>>>> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
>>>> @@ -492,11 +492,11 @@ atombios_dvo_setup(struct drm_encoder 
>>>> *encoder, int action)
>>>>       int index = GetIndexIntoMasterTable(COMMAND, DVOEncoderControl);
>>>>       uint8_t frev, crev;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       /* some R4xx chips have the wrong frev */
>>>>       if (rdev->family <= CHIP_RV410)
>>>>           frev = 1;
>>>> @@ -856,8 +856,6 @@ atombios_dig_encoder_setup2(struct drm_encoder 
>>>> *encoder, int action, int panel_m
>>>>       if (dig->dig_encoder == -1)
>>>>           return;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (ASIC_IS_DCE4(rdev))
>>>>           index = GetIndexIntoMasterTable(COMMAND, DIGxEncoderControl);
>>>>       else {
>>>> @@ -870,6 +868,8 @@ atombios_dig_encoder_setup2(struct drm_encoder 
>>>> *encoder, int action, int panel_m
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> @@ -1453,11 +1453,11 @@ atombios_external_encoder_setup(struct 
>>>> drm_encoder *encoder,
>>>>               (radeon_connector->connector_object_id & 
>>>> OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
>>>>       }
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           /* no params on frev 1 */
>>>> @@ -1853,11 +1853,11 @@ atombios_set_encoder_crtc_source(struct 
>>>> drm_encoder *encoder)
>>>>       uint8_t frev, crev;
>>>>       struct radeon_encoder_atom_dig *dig;
>>>>   -    memset(&args, 0, sizeof(args));
>>>> -
>>>>       if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>           return;
>>>>   +    memset(&args, 0, sizeof(args));
>>>> +
>>>>       switch (frev) {
>>>>       case 1:
>>>>           switch (crev) {
>>>> @@ -2284,11 +2284,11 @@ atombios_dac_load_detect(struct drm_encoder 
>>>> *encoder, struct drm_connector *conn
>>>>           int index = GetIndexIntoMasterTable(COMMAND, 
>>>> DAC_LoadDetection);
>>>>           uint8_t frev, crev;
>>>>   -        memset(&args, 0, sizeof(args));
>>>> -
>>>>           if (!atom_parse_cmd_header(rdev->mode_info.atom_context, 
>>>> index, &frev, &crev))
>>>>               return false;
>>>>   +        memset(&args, 0, sizeof(args));
>>>> +
>>>>           args.sDacload.ucMisc = 0;
>>>>             if ((radeon_encoder->encoder_id == 
>>>> ENCODER_OBJECT_ID_INTERNAL_DAC1) ||
>>>
>>


