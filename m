Return-Path: <linux-kernel+bounces-740784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89901B0D91E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AD9547DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701C72E92A5;
	Tue, 22 Jul 2025 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KlyEiMC2"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D92E8E09
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186462; cv=none; b=K3woERz++DLQC7izQLMAd2Zhr3VlNXIJt3vJJlLzeWcsJ7Z0PVP4xEalxJVndFRsu17e3ewkjMsQM2qcTS2z8og1tp3e6xWPeXVQZRQVHbKkt42M26O/sJxj5iWBCL/K8UnTmouahXQs5qqaUHqzvEazAbWFhOgvsUcGKz8llyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186462; c=relaxed/simple;
	bh=sf1+T0JcwOlPtAmaW12tuPWOakYQlJPwEqSiEGG12QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMMGdkEHDNilERmPHoD5CYk3Zb/HUzYEuAr6UHTCNzgjxi/HrA+Sp5eZerV0x7K+qWikfxSMT9n2eQwtdmXkYC3F5otLsSzR0oR+WPniSMYy7AILGdmlxYCnkyk97IUChfOqa5ZkE0iSEJb4KxaeSX0mikM/5hv8pDRoyn2X8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KlyEiMC2; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e2a7908838so11509135ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753186460; x=1753791260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPVTwTdFTsc751gaYm/Hhn67W96rQTewFcoGBTIznqI=;
        b=KlyEiMC2gZlyfQCsKckCWISWqfpY6xjbr9ICQsO3Uu5Qc2CyuxQHQ3aVy4MeLvsI8Z
         8BJWLzKFlDVgZGoMON1k7utu/g0SkpkkWKjLrVNr7zG02u3m8vGBgrOFkOVeyLFIVaU7
         cKc47QIreCbAKCtz1ep84VnpebxO2TpkzzGsSv3C3Pz28YMBKU4QPVI4Ds58KIj/tHli
         xTwqymMSicoASwZuev2rEPNiesNHr3Mama25tHBz/JpuryZQWz8rikAU0vMcEwjz+6td
         5stsPl74bYY1QoeCbTwLDz8g5xk4IkQpsgYdm6/IlRyplfruuDDdG+S8Rxz+4zoPnCJv
         A0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186460; x=1753791260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPVTwTdFTsc751gaYm/Hhn67W96rQTewFcoGBTIznqI=;
        b=ns9/tEHNuOFPiTZsGYwUBO1sl+mpW9FUMaAor7oX+hLckKg7LF6i0+SJXmVc1ITlou
         VmxbOl23bjBOq6/vPqN1vxPEDIHE3DAOHxPlH9oNalBvhIH6b14NNY4lalXYauYYZng9
         uS599ZD5ZRdK1OcM9tDo2SeNBB1TLKe/qRVzOnVqBX85yt5dDwQ1BlPOCjeUyocjQyYm
         da3JI6fdhGHOe3bOP/CpFCCZbC1GNc4osL2RrIQYRGNfVDwSpAa+Dj/lZZy1wrsvV2O9
         pXR6zvq4b5tPvtULymY6EAvFzc8MWiYwrugku2CxJvoXJLHj22TuWAOFfSmE7+iil1NT
         xpYw==
X-Forwarded-Encrypted: i=1; AJvYcCWIONe274fIZkswOL5el1T+DolPpmCerM785/rAfzIJags9DPWScxVevHrb29r0RpU14zyTSvb+rDEBoA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpMgVzLyfqT4zQLGhm3/Sg3wyjrFFZf9Em1HrToqWSiuJreil
	QdMMdpKlBHgP6ySdPKM4Io2je0vw7Mz/fK+x7+t/4UX4sw6z8cNUUvYgtvMFvLPoSKU=
X-Gm-Gg: ASbGncuM3LPtWsT0FPTxq6BAoI6cLyE7U2nDpmOF8st66OdhR2nxdG1zPlBwZSWbk26
	KwJE6Ad/Z88oMiHl0emoAzc8sVm3Hk2czHICeOATf0ZZu8/mu6NMxjc+nUfngQZkBpxjf6g9xIx
	akcL9LK2QZMnLg7R6asf7l6mwa01Ycd1+TdVsGCHMBU0a1ifp0vaIJi91SzwWmb2+YDJAw5a5en
	08xToKY/Ne7AH5uHWL82Fk+8bVrvQ78L9owj+w0xQUD8U8oVx1LGyPoN6/zalFIpWe/lBIX9CU7
	89+dRD708A09WXq6ABxJ1PsQouxxCA8/U7wGtrGb2hv8paxE8WZKQ14GQkYnvzXDQasJrJh7p2x
	R2m4JEQSP1yVbMuzeP+g=
X-Google-Smtp-Source: AGHT+IGWtOls1B66eWDWTPlotWRsVDE8PPR3Zo1JfCpc3xDLAOtrzQLxt3z8FA6rIVPpDcscI4nFOA==
X-Received: by 2002:a05:6e02:3c87:b0:3df:5333:c2ab with SMTP id e9e14a558f8ab-3e282e64ee3mr277030295ab.17.1753186459712;
        Tue, 22 Jul 2025 05:14:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c787e63sm2495145173.9.2025.07.22.05.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:14:19 -0700 (PDT)
Message-ID: <8acbc346-98f8-44fc-9675-0c3a7da87d21@kernel.dk>
Date: Tue, 22 Jul 2025 06:14:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking
 dependency detected when plugging USB stick after ffa1e7ada456
To: Hillf Danton <hdanton@sina.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: thomas.hellstrom@linux.intel.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
 regressions@lists.linux.dev
References: <20250722005125.2765-1-hdanton@sina.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722005125.2765-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 6:51 PM, Hillf Danton wrote:
> Try the diff that serializes elevator_change() with q->elevator_lock if
> reproducer is available.

Hillf, these seemingly random and not tested or thought through patches
flung out in response to reports is not useful. It just wastes peoples
time and resources.

-- 
Jens Axboe

