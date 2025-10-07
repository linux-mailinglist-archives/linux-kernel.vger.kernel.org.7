Return-Path: <linux-kernel+bounces-844856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A39BC2ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D84189EFF6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09691DFE0B;
	Tue,  7 Oct 2025 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBMxYTq1"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB31E5711
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878992; cv=none; b=Xko1b6otYNUxR0qWLw7/Y71RgO4knyUWrgioCV0Kdoeai67yV2rwdPaleCPJ6byCzSUrfsB7f96jezl4cyKdbZ64Z1bHSBpmz3m152Ary19J1SxzMF988rOcrGCj/XG1xcEIBk4+gpxjhtdtqGH9hvMzp547pNOrUqjXWohvnBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878992; c=relaxed/simple;
	bh=eIfWtUHSviSKN1zw89KrShxCLlPX2dyN+NvsS50rAhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDMFAfDJjGKWG92g4dUjBaSoyGwV+EmPp2U5OsxIEWTfIqtm1b6CFNZBhM1qYbx3AJ4fwnLXNVm8bAUkmZWSDInkw7xiImuqkOYTFXBLCpx5y+SpRu5CAT8/Yy3HIvnncNQCu2ogCyzZxh9R2Rev2vhZRIAfwxRFJJuFd+Anj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBMxYTq1; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-428551be643so54216945ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759878989; x=1760483789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SD5yIh7mchDzfy+pmfKeaAbFqsdOLLaDl138ZLpTy7s=;
        b=FBMxYTq1H6gKXC0koH+fLP0rWoAqf+8vIp8SgCALx6o2qsltl4AbhxUVwumzhRRtKV
         F6quZmcW8rVmPfJyEdzRZrWF8kzXqaoOoqILgY4CE85GFcNDKzpOieLM3Yf+1mj1dsgV
         HkaVx9UjXgBnEopLKTrpb3v07kXalf32dLeV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759878989; x=1760483789;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SD5yIh7mchDzfy+pmfKeaAbFqsdOLLaDl138ZLpTy7s=;
        b=Qe9QSitcZMsY1tFYDxUICJ2990llH+Q6LkIDLXy/oVGhXEt6sBtt5mNHI8yqaSS0jP
         Ej755bhP/DQSZUCox6By0V6DjfCW73lPX/jjoN+xDP6QYd3xWg1WSIpNDv2gNsnpAq08
         NWbP8SG15mQVtOzqhCAJImUSk0o7ALIAZ8cvERbIf4Uh6z+hy5JvWZczRRqMJb5XxZCa
         JMJefxc2wVCH0GhLDhKCNzCiPpqX37wg/+ncNMETPrvV+QJAjSS93+UNFYPIKMgoJWJ6
         FD9RoWbK6XoTxYZxdW8MxZUSvUuGgYCtoR0yPq//8gHBo9dk+ivjzryDyR09OX+fQ1gy
         9vCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdhO42tM1HtcawwGH4BDNNWSBGrPZ4jEDgqNpwD6TYNSHvdV6U4cX+16bdEbDEqxFOhA8XBhJd0Ja2J2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylp3qoYK9KeeuVT9mYWd3EX2AawgqLSUG1QZSJDCv9pU+Eorgs
	zqHFoUEwOaAwmqz4zL5OVhWQiWeNnuYiln8+XNNM3pC8Fd/D+3Oa36It8Zi/plF6Bh8=
X-Gm-Gg: ASbGncsymADotY3tlaOM7EQ6BjtSVTVYncnMMWkOYan2FodwFjqJcWU2lZ8rV0Dv2Zy
	ToEt8kwkZQjahfzgIHhPpW7ILiDHHhjhmYXGvu1p088QrTU8hXZIKrz7E2++AEmQXaEAVAaHGQf
	4O+OnnoO8uXb+xvTgzNI5Xw8Fpey2FQGgvMkSrxbX/oOqxVUy8y1aul+zYotMlYo9r5ol+bqWuF
	JInXBQ/JZW55zt76AR373yiXeTnp12GA6hngF1Lg8yLTUIiMH+PQUNz7qygd37v4Cd8Zb4dnakR
	PDZTtx8klGeqWYt4Fwvo3D/+WaS5oYDuMWTIbYz6QDAAHnDiUmRwzneygJel+VRK4MdWe3W998t
	ycCIRb8Gay00oVEM4N1UR5ya9z1p8GGPp+c6GAbm43RMVq+yxEwXRE2vF4Ss=
X-Google-Smtp-Source: AGHT+IFtnjgHVUKlgejgjQmfrY8NhWm0K4ECYfhZKgNrEOhgOUSbX5KisBkAd+fZ7CYn0EsvLjgWXg==
X-Received: by 2002:a05:6e02:2581:b0:428:7f76:4ec4 with SMTP id e9e14a558f8ab-42f873d2956mr11775395ab.16.1759878989058;
        Tue, 07 Oct 2025 16:16:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42e7bd2f139sm58970215ab.8.2025.10.07.16.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 16:16:28 -0700 (PDT)
Message-ID: <f774da25-ab98-4731-b78d-394d8e3a4c3a@linuxfoundation.org>
Date: Tue, 7 Oct 2025 17:16:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/komeda: Convert logging in komeda_crtc.c to drm_*
 with drm_device parameter
To: Rahul Kumar <rk0006818@gmail.com>, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250926093008.1949131-1-rk0006818@gmail.com>
 <CAKY2RybMM5jcOzO_mknsdH+m9-T+Qe3yMhRrdpV_VE4paUrAKw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAKY2RybMM5jcOzO_mknsdH+m9-T+Qe3yMhRrdpV_VE4paUrAKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 11:51, Rahul Kumar wrote:
> Hi Liviu,
> 
> Just following up to ask if anything more is needed from my side for
> this patch, or if you plan to pick it up in this merge window.
> 
> Thanks,
> Rahul
> 

Rahul, no top posting. Please give people time to respond before
sending a second email asking for feedback. I see two messages
back to back from you - perhaps an error during send.

> On Fri, Sep 26, 2025 at 3:00 PM Rahul Kumar <rk0006818@gmail.com> wrote:
>>
>> Replace all dev_err(), dev_warn(), dev_info() and DRM_ERROR/WARN/INFO()
>> calls in drivers/gpu/drm/arm/display/komeda/komeda_crtc.c with the
>> corresponding drm_err(), drm_warn(), and drm_info() helpers.
>>
>> The new drm_*() logging functions take a struct drm_device * as the
>> first argument. This allows the DRM core to prefix log messages with
>> the specific DRM device name and instance, which is essential for
>> distinguishing logs when multiple GPUs or display controllers are present.
>>
>> This change aligns komeda with the DRM TODO item: "Convert logging to
>> drm_* functions with drm_device parameter".
>>
>> Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
>> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>> ---
>> Changes since v2:
>> - Added Reviewed-by tag from Liviu Dudau
>>

thanks,
-- Shuah

