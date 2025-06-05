Return-Path: <linux-kernel+bounces-675142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3291FACF975
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 00:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B1F7A3AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 22:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FF27F18B;
	Thu,  5 Jun 2025 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rkcmRDqR"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F021F30AD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161045; cv=none; b=kaQvIOBrwWC4r7MMu4SN9J71jg2lp1B2Atnc/flrrAQhdrPgQM4YsxT7xPt1MYzEj9fRPlFKA9/c4TUmSFSusoZaGgq8qAY55Cx4z3D6Isqrcc3daZrn8jBdAHhhGyd/ktsi9X3di/a7dIgKE2WNNxICReGDQn2p620lZR2sGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161045; c=relaxed/simple;
	bh=wAoJF+V1ixKUD7xCt1cvsGQns9uQ8DokbH9TB7UIoKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn955aGU9slFamrebJoNxKvnEPTastrJoVTfV5omLv2OfTJfgNgV+a2QYPcZw7jSlDNKn7ysyVTwDlMMSsF+oPFDeeKRR+YtzSLLARL1jtiQ8WObYCYZZL/wACg/fGv/1SEwcJxRy2vMO1adxtnm6ySJaBtVlxHCSIWxYVBP5yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rkcmRDqR; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddc5084952so5685655ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749161043; x=1749765843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUXnGKzBcTguV8+MTjnylUmPLATGpHiUDWNltHtDUyI=;
        b=rkcmRDqRXNaaEz7jIyIVXofLti6kl3R0ADBkPl0J2yra5h+nW/gLD8bGtTEW4/rZGU
         8tIKzfrDPxu+/jeC46IThtEPXm+JhNcKRB19n4J95d+UDzOYDDrU6+Y5wa7qYeUKJZ9q
         M0Hq5c6YMVEp02dObEdNyynvTe/gg7Nw6dTLBFB2qH8RInQd6o1GUlQp6rZ+pu0KaSJu
         qpLsriM3pklV3QosSRu4qpbS52r3r7glGUGFhm0+Nwcd7euvvgF5QfeG2hFtlGkPa5gM
         GeP1IisuXXiAQ5zp8wyDCcjXnBPr8weJCOmpss2VQjSO8qZDBwJmCQHWAaMQB81gahUv
         H7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749161043; x=1749765843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUXnGKzBcTguV8+MTjnylUmPLATGpHiUDWNltHtDUyI=;
        b=vRDkCFwqcI9K7VRxH+s+Jlsnjsz1klmRwmro9qENbXqWDKfV/fJd+LZVLxjXkqBOyh
         ViFn1gh9xIrc6F13C5j1bjBvNByQz7mlAG9qOVlynbitZc2oF4obIm/r+vqT4foeDlTd
         VcF4cA6AQyx/F7bnC7HeV9EnINwwRjgIvlyJm8ee3yYd5ECJoVrlk8WOjZ9gSTUKyKq5
         wGsjx2hRwAhknSiXfEB28IP6RhX/BE3GgJmsm4wIASKj77uuI4rauTtnfO5Bonpjsp3s
         Y5TcGTWWKwWnEApsrBtCnTkm/Dt8GHcLmcZRqEPF+tPqR/89bRHAv8jyvr/Phh2gnFHp
         ohWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2YgNj+fkFCqy2KX5CmSoc7I0rZo/JaNJWIrzseO8j72MUWYwfIou1833uMhGTdmu6qz0Tee/T9DDyjfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtZ81mZ8gIDst/duyfHiWDpDccjKgn442pRaFteBjnngGN/O0
	zjuIDYX3syV7rb13AhzpvGkxMcJ5pzR4dBrTjaYCzTHPeuCXQSEmN6hgstabiCXL63K9lJR1cvX
	wpO5E
X-Gm-Gg: ASbGncs9a14KYhj6g+qjuiGIxG5lef1W+DpwFKNaVEduuMYksVeKwT+CZwwZ7VgyVyV
	O75dtPUEqh61fLuLmuozy5BYuzPCGORHmvlksSKCbPEvpo9v5q8UTTYM2EbMyMxNWMe3GCL7ZzS
	I1sUzBuO2RwBDrW2HWBqBeehf7I4ckCtMtFBIJRmsZtpV2oQNjkHPt9FWh0bpolkomIFfTuWxmy
	VQBAVgHNe34imGaD/kcleO8ha3CleC/VpW2qusXcFBnOPWk6Bn07x08c/cUZQEMsG0lBT+vEcQq
	JDY24Yb/8MT9vNNcuviY5t0jzLY0Yh0YXWG4iSQfTIh2QnFq6rqGlwcGRz8=
X-Google-Smtp-Source: AGHT+IGgfAKEnkU5dJt4CEDcabnlosi+J8OfnBK+4UySYontAor1SeZ9LKCEkVPHVVC/2Z7AtYqeog==
X-Received: by 2002:a05:6e02:3090:b0:3d9:34c8:54ce with SMTP id e9e14a558f8ab-3ddce4a9ff5mr14367375ab.18.1749161043046;
        Thu, 05 Jun 2025 15:04:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-500df5fa234sm91779173.119.2025.06.05.15.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 15:04:02 -0700 (PDT)
Message-ID: <f3129b82-e01c-4213-8582-dcc3a6bcf807@kernel.dk>
Date: Thu, 5 Jun 2025 16:04:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
To: Keith Busch <kbusch@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoph Hellwig <hch@lst.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250606075230.6a13c53d@canb.auug.org.au>
 <aEISwo8LR8hG0zyV@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aEISwo8LR8hG0zyV@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/25 3:57 PM, Keith Busch wrote:
> On Fri, Jun 06, 2025 at 07:52:30AM +1000, Stephen Rothwell wrote:
>> Commit
>>
>>   10f4a7cd724e ("nvme: fix command limits status code")
>>
>> is missing a Signed-off-by from its author.
> 
> FWIW, my Signed-off-by is in the original posting, so it must have
> accidently been chopped off somewhere on the way.
> 
>   https://lore.kernel.org/linux-nvme/20250520202037.2751433-1-kbusch@meta.com/

Either maybe some manual amend that Christoph did, or he's not using
tooling like b4 perhaps and manual labor lost it?

-- 
Jens Axboe


