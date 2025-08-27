Return-Path: <linux-kernel+bounces-788819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D41B38AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD58366E84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E8E2D3228;
	Wed, 27 Aug 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="frafN4oT"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976927E1D5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325435; cv=none; b=Zgcq0yQNxWq8Hq1aW5YkJuuOag1X09BWFWtXu2IPAjZ+elOB0zb9eKMyKfZ81NuU28953RtPwd/Ae+elRIxstyawNZjU67ZzRLDcUiZP8me1fq6vVWfqJb40ikNWYZ+GwrutTIWvuFfG0kOuw3NMVgA9ufKok7PPuJF47jtmLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325435; c=relaxed/simple;
	bh=i/vJDjRkU+5JhZayvsiPCU78Z43nE3H660NG9b5Blro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pv4MpKox8A7DrQoi4Q9jWfxuRiLssssP3nHC0enOIHlarYzOKQr22MVx9YU2euUO4oifLnK6OmbS1LhxZnNUSYvqoIBMIb1jMY3BErkZzca9g0VSSpfu4AuYw7h/sIbJKGerIlTziiw+f3CLRrVkx9V0RI+DWv3J/xBUvPRzkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=frafN4oT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7snkKX1bOycmBGsSmam3krw9hLMbCevZWz6AGkFb1rw=; b=frafN4oTk6CDEZo/0PbsvgHL+z
	SwD8zAoiyolzKArNExErCueEtfu/m8qPipGkAQ0UKlTt4R29gcla3soDWsq6BQcW5I/rcsUrl7R/3
	+azXWEERedpx6AHOGAuBfRv+EojaOVMHQt3Jv0rAdu7xFyWBuhNv6stLecteGBeZUwA+cIXYDd8MO
	JgCEJbPYhgMe0l/EWqNacWAxNp1eGDj+q9l8bgNebfwZK90iX/Fip66uXYn5BXUty/hvjE3fC4HS2
	ysVZtNiSawoizkVTaDjtt/fdp2i8gXaTIee8DbQBlvWPH/Ua7McUo1PwGezojPPHB8j9ATz1uksIA
	BZCe1bhQ==;
Received: from [189.6.13.79] (helo=[192.168.31.42])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urMTM-002bFn-Vr; Wed, 27 Aug 2025 22:10:21 +0200
Message-ID: <5e065f3a-9237-4798-9380-11c43b477882@igalia.com>
Date: Wed, 27 Aug 2025 17:10:14 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Document num_rmcm_3dluts in
 mpc_color_caps
To: Alex Deucher <alexdeucher@gmail.com>,
 "Kavithesh A.S" <kavitheshnitt@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
References: <20250823202540.487616-1-kavitheshnitt@gmail.com>
 <CADnq5_Onr6rR12NVagwMHURPfuQxBoVq8Qhui6heH_m-5eHsXA@mail.gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <CADnq5_Onr6rR12NVagwMHURPfuQxBoVq8Qhui6heH_m-5eHsXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27/08/2025 17:02, Alex Deucher wrote:
> Applied.  Thanks!
>
> Alex
>
> On Sat, Aug 23, 2025 at 4:25 PM Kavithesh A.S <kavitheshnitt@gmail.com> wrote:
>> Fix a kernel-doc warning by documenting the num_rmcm_3dluts member of struct mpc_color_caps.
>>
>> This is my first patch submission to the kernel, feedback is welcome
>>
>> Signed-off-by: Kavithesh A.S <kavitheshnitt@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dc.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
>> index 59c077561..06f05979b 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -234,6 +234,7 @@ struct lut3d_caps {
>>    * @ogam_ram: programmable out gamma LUT
>>    * @ocsc: output color space conversion matrix
>>    * @num_3dluts: MPC 3D LUT; always assumes a preceding shaper LUT
>> + * @num_rmcm_3dluts: number of RMCM 3D LUTS supported
A bit late to comment, but I think you should keep the "always assumes a 
preceding shaper LUT" part.
This info is still very useful and links shaper LUT caps to this attribute.

Melissa

>>    * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but single
>>    * instance
>>    * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
>> --
>> 2.43.0


