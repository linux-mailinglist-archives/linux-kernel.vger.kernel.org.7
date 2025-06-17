Return-Path: <linux-kernel+bounces-690399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD87AADD016
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96A51631C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382520ADD6;
	Tue, 17 Jun 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="guK+8hum"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58D1FDA7B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171109; cv=none; b=Ntlw/ctYlgJ7KKcUe16nA80wmDXPNG+n3EKxhQEUjHKkhWYAUcxb4uztYOWOWV/jl8KKXBhtfPUF4ceGwvi5pkVAd1jfVqluD6aKlkmEHE+FYRFrNvMKzDlQOD//xPuSCpSs0hE562lL0l+jJdX+GflN9KSaiypEs6cS6UoEcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171109; c=relaxed/simple;
	bh=lCKA3/SlJo37tFXLmmWB118bUZSJDi+rBnfI8bPOF/s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FrdcAqrxaapVxysSXQfTVMIvDSgjw5eiXNv/3q908avQ6MKc6isocbB89EbvJxoYcugFR6XvKPGYKd3OkBwGpl68A7rfJMoHp5pOPsHMyf55NrrRwFfRmmh7yGwYjD4auJnn1DIT6Bk8IaIvX7TZsoTt3d/emPmHL9nkk6kXyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=guK+8hum; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8eHJgER+R9kCEbZ1L3X7vCzptyp1NrKUg6DntB/MAXQ=; b=guK+8hum7ftX7NWo0v1A9Olhcl
	In/Q4ehx8mgJVGTwOWlqldsRPcgAkjfFaKZ+fF6Y//y+E0iaheLKwJWun7RzevFBNSeuLMqfq2D3Y
	cKtTPBq6J/jzcFAqMwSwefENE4S83b3r6cwg5weJT9xQCFD+D5q/ixn92ehtGEzEp0q3wtpC+rCk3
	T1Vxf74wkgPXl3892YyYMwBgDgHyFL9+dnyTZLbKViYR5JlQzlxdCHVeohptTZGIy201ogTJxSorz
	9iAACx5DWMXG8Z+WEFDWGkb40Lr7Brqr/9c4N3u37V3fMy/wjFXTqixdXRCOzw9Yl/K1Wuy98d/kC
	Kl5g6tmQ==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uRXRx-004dC5-5G; Tue, 17 Jun 2025 16:38:09 +0200
Message-ID: <7d82dbc2-b902-498b-a70d-8be49c1be87a@igalia.com>
Date: Tue, 17 Jun 2025 11:38:03 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] drm/amdgpu: Make use of drm_wedge_task_info
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: jani.nikula@linux.intel.com, Raag Jadav <raag.jadav@intel.com>,
 dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 Krzysztof Karas <krzysztof.karas@intel.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 simona@ffwll.ch, linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, siqueira@igalia.com, airlied@gmail.com
References: <20250617124949.2151549-1-andrealmeid@igalia.com>
 <20250617124949.2151549-7-andrealmeid@igalia.com>
 <5db1dda6-0cd7-4fc7-9a22-8ed57b12ada1@amd.com>
 <63b4fb79-8132-4c05-bcac-3238366899d9@igalia.com>
Content-Language: en-US
In-Reply-To: <63b4fb79-8132-4c05-bcac-3238366899d9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 17/06/2025 10:22, André Almeida escreveu:
> Em 17/06/2025 10:07, Christian König escreveu:
>> On 6/17/25 14:49, André Almeida wrote:
>>> To notify userspace about which task (if any) made the device get in a
>>> wedge state, make use of drm_wedge_task_info parameter, filling it with
>>> the task PID and name.
>>>
>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Do you have commit right for drm-misc-next?
>>
> 
> Thanks for the reviews!
> 
> I do have access, but if you don't mind, can you push this one?
> 

Never mind, I can push this one myself :)

