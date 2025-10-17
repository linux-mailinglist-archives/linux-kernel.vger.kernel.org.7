Return-Path: <linux-kernel+bounces-858589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C1BEB3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435B54260D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059F31DD96;
	Fri, 17 Oct 2025 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0J8mXWa"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D32A257831
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725974; cv=none; b=KRlr/im6kW4JIZb0SfLY1C8tqrZ+92gzr9r3I2Az7firW5Vc2k6tgae/KsIFP5PWkBhcQq2kpWlQHcrJc/IG2gQpaKP1xkHs2TcERXRfLaKkNpK3dWxCxwXIuwnHDQXHJrp8PWu8WBl/kbVdO3OqVenNZnKvDT6aIvkwQ9k2/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725974; c=relaxed/simple;
	bh=uQMVWtUguHqyXYKwfPXnmVSt9RtvFAq9F4QYgyT44jg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JMuqPaCiDAdsYP6m4IVCcF8/dOpx+lMVePIn+RCTBj2WSFE21jiby3mPV/g/dmU497ZfuNJXjzSKQyaE3WS/rYcsCi2CFdO2puQss55hOzTCy+rPcC9LGhGXSDiIkDw/WycX8EYAOWYSHiHHLUwArfM6VOT+hO6ZFHRlgs7Sehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0J8mXWa; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7ea50f94045so50129086d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760725971; x=1761330771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9KlW+lpogSSOPGbpGvaXOe7oJB/E4tzSfCU9kHdDzs=;
        b=O0J8mXWadkrn9EMgzNGImrOSn5k6oR06hCLnAWPNBz6VfSx6b8V3JTqwOjhRXXMGhr
         NdLyIXfYuG3hOC4kxcgSI8EI5s5Urfi+CFfms6Hw8KRttYXMrRkKN9u0y4UFpoKBiT6a
         E1m4lVRJmX/KKX70bywuyF5q1ddVAliafxnp9HTBQSt3IaOgu6BSJyvHOIVtNSUj3Uiw
         Ull7YogK3NA4z9VMODW4HawlOSn8gwh00E2xpxMOYJSO5WMFmpLLZGF/ePDxVKzZTme3
         4ZdmuAu+1tWZIR8xH4OYaxzsNakXdDLoYhxJywf4h56AdQYYlm38Pll1d3HYcq+3Aet8
         w1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725971; x=1761330771;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9KlW+lpogSSOPGbpGvaXOe7oJB/E4tzSfCU9kHdDzs=;
        b=kX3Pr6zpOeUdNWYNwwZOHtqMeMhx8Z8Xq3kJYKsy4O7zSjDyzcRwUI6fPt+xODufVA
         xfUgzWhNGWSb/mxTE0S9EKFMyq4QUVLx+QHt7edgpXTaFdfmnWiCbzY9GttqIJ6qfk1a
         ogAw8kU9HvqHB7Dh6rWPG14xVBC+Ay1yHbdn6MyezoFrk/uiExYGQh3xpKmPH5YnDSmo
         BYMsYyD+fzR8sGCNk3kBRV2khJU0gR9eZhGJMezTKx3xXWOP7c7AeKgBNwKZq3Y4j6nP
         75Ap1OlZnq3auDW4lgnIuB6EVx4M8vRxnChFa0D/toJZM4b3FiecyqYCrj/6t0kGedMk
         rCZg==
X-Forwarded-Encrypted: i=1; AJvYcCWV58Tu+ysqIq08PVRo6LVnWXRxWY5bPfz6fbW5Yd8Dycw2XisvKf3iGNG7bTW7QBmCz9eZMPzc6j1orvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJZVMB0YsFMmNUD15uHDOQJSzU54TRCAF+tlxYAa+JNEmZG3q
	ymDvKRne78zmp7LlfkuSZAGXY2oZbDNkUeeoVlBO1EP6xnoAFF8JG07/90rX/R+2
X-Gm-Gg: ASbGncv1HUc0Z34W3iR2chAMhR9T7AqBxZt49qosl8GEnIMlP8VjAfjwtALvJbtIqu1
	Cd/z99m02uB+JRyOlzSeUD6bo9/sImD6XC0SxchKOXAjPQTZ86EFpMTTiMhhSINHbRC7xCQy+UD
	NjW6utM5WY6BZmPZcFq1WKtFK0xfp4smAVNKxBZItjv7sKnjZsXNArGL1Avo8sV0ssF51eplTIE
	mpc9WOHtPWjrM8L1nB4GQMnxK1lIFt2O+oBrrpt0oci5gm3x+hWK29LCHOLc6EVi55EH5gNQjrc
	omu4cfJT/KNn0AJ1WanDs2kgHcFyQpBaFEQDOrETuF281ivb4PBboM+E7SCtbhsrD1mvo6MbQp7
	MdLo28XZkib9RnBEPtWLTa+DG1/FHRFKc3zwqxGNsfU5Ui0YwhDTiHPv+tkxxHpkYzo0fcgqjMr
	lbAGuG1T/AlYHE8LloH4fmRXCeZWUsPHdFT+VP
X-Google-Smtp-Source: AGHT+IFVd7y/Qyh5ATMsYkQxTDgYS9+NlSf6Mnzo3x3NdEUjkrVLtHGmbQu+5MVS3w84oY1mQ/OE0Q==
X-Received: by 2002:a05:6a20:9149:b0:309:48d8:cf1d with SMTP id adf61e73a8af0-334a78fdda8mr6800910637.18.1760725656169;
        Fri, 17 Oct 2025 11:27:36 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.200.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7669392csm424003a12.18.2025.10.17.11.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 11:27:35 -0700 (PDT)
Message-ID: <8c6b4be3-fec1-4097-9be0-6bd5d352c2e4@gmail.com>
Date: Fri, 17 Oct 2025 23:57:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: bhelgaas@google.com, kw@linux.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lucas.demarchi@intel.com,
 rafael.j.wysocki@intel.com, Manivannan Sadhasivam <mani@kernel.org>
References: <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
 <b144ae1b-8573-4a71-9eaa-d38f38e83f4a@gmail.com>
Content-Language: en-US
In-Reply-To: <b144ae1b-8573-4a71-9eaa-d38f38e83f4a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/25 23:52, Bhanu Seshu Kumar Valluri wrote:
> Hi,
> 
> I want to report that this PATCH also break PCI RC port on TI-AM64-EVM.
> 
> I did git bisect and it pointed to the a43ac325c7cb ("PCI: Set up bridge resources earlier")
> 
> Happy to help if any testing or logs are required.
> 
> 
> 
> echo 1 > /sys/bus/pci/rescan
> [   37.170389] pci 0000:01:00.0: [104c:b010] type 00 class 0xff0000 PCIe Endpoint
> [   37.177781] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x0000ffff]
> [   37.183808] pci 0000:01:00.0: BAR 1 [mem 0x00000000-0x000001ff]
> [   37.189843] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x000003ff]
> [   37.195802] pci 0000:01:00.0: BAR 3 [mem 0x00000000-0x00003fff]
> [   37.201768] pci 0000:01:00.0: BAR 4 [mem 0x00000000-0x0001ffff]
> [   37.207715] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000fffff]
> [   37.214040] pci 0000:01:00.0: supports D1
> [   37.218083] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
> [   37.231890] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
> [   37.242890] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
> [   37.251216] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
> [   37.258309] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
> [   37.265851] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
> [   37.272896] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
> [   37.280439] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
> [   37.287459] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
> [   37.294986] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
> [   37.302011] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
> [   37.309536] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
> [   37.316595] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: releasing
> [   37.323541] pci 0000:01:00.0: BAR 5 [mem 0x68100000-0x681fffff]: assigned
> [   37.330400] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: can't assign; no space
> [   37.337956] pci 0000:01:00.0: BAR 4 [mem size 0x00020000]: failed to assign
> [   37.344960] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: can't assign; no space
> [   37.352550] pci 0000:01:00.0: BAR 0 [mem size 0x00010000]: failed to assign
> [   37.359578] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: can't assign; no space
> [   37.367152] pci 0000:01:00.0: BAR 3 [mem size 0x00004000]: failed to assign
> [   37.374192] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: can't assign; no space
> [   37.381709] pci 0000:01:00.0: BAR 2 [mem size 0x00000400]: failed to assign
> [   37.388720] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: can't assign; no space
> [   37.396246] pci 0000:01:00.0: BAR 1 [mem size 0x00000200]: failed to assign
> [   37.403795] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> [   37.410513] pci-endpoint-test 0000:01:00.0: enabling device (0000 -> 0002)
> [   37.417796] pci-endpoint-test 0000:01:00.0: Cannot perform PCI test without BAR0
> 

In my setup is pci topology very simple. Just two TI-AM64-EVM directly connected to one another.
One acts as RC and the other is EP.

Regards,
Bhanu Seshu Kumar Valluri

