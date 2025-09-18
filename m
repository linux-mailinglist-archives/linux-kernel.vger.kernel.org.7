Return-Path: <linux-kernel+bounces-823403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F16B86545
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F99545D54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41DB286438;
	Thu, 18 Sep 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlXv59gI"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98067283FE9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218076; cv=none; b=IDGD2OJeQ7+iWh7GzUjnqIciYe57e4Z2HMyl4Rmu8OlrTKsaJTERxFp+c5nQaY2EU2OzPaqoD2RDai6DsRBX6H7q0hzIhFzcJmdsyNIeGkoRb2NvmEq905PxphJhUVORueWHEH+Fu9ELph59oK2bHHNUVbJPA5vKlUnFQPJu+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218076; c=relaxed/simple;
	bh=pyu+PEknQKVBR7WM+1Odw7v7Lj38JV9BuP14vt2oyn0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=c+jAowp98G3A8fHmkbzOYDYHNJAWM2fJ4maruoZfEtOFGGarhz4azyg2F1dlADxHw/TrJ3lIwci3H3ejPF35+zK2ft/agypQ8Zgtqv6B07GLXtILs+ujIMQHV9zJGZfXagJBOkf8MIU7OcbOaNeQcOB1ktkUmFKtsfHpWoGJ02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlXv59gI; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-35e9f3095ebso9453431fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218073; x=1758822873; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pyu+PEknQKVBR7WM+1Odw7v7Lj38JV9BuP14vt2oyn0=;
        b=DlXv59gImnQFLcoeqPcuwSBAwgPT6KtnnkHeJeN0SoIly8nTOK/EmYmHhs0FW/FH/0
         Q/e7qMPH9neA5U58EarKZMBeGU2HJ2guug16OhAL3NlCexqUSjzzdAzKUKccNVHONXDa
         ngDGKj3EmiN/9AtmQ65b+XtIcM/aplGayAJslOrG7p59D/gCdwgqZ+YIovg/rJ8Ej+QX
         w0h3nO1KKmfXhiERmW+5qQ6h4VAWFaxa+x4mJWRv2YP8wbwcG1PLZ4K/jHzgCDGghBsJ
         NpkgQg7txZidFnMjb00zWiPK4+UkkzOMWQ77MSmYnKkehLlPEDfsYXn/Cc/nK+Mrt/RK
         2zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218073; x=1758822873;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyu+PEknQKVBR7WM+1Odw7v7Lj38JV9BuP14vt2oyn0=;
        b=KUyPr7u4YYgCFpJNDLp1VwqKoMtKr6X/08HcEW1yP5+pmQSp2y80gsTb5A59EOZe20
         TH9cKPl/gJ2M5jQPoP90XeuqXJ3phkY7eZBLNDtZAAom1uFY817umqkqTWS4ibZxeXHL
         HR2mimALakAQg+SluIXRqOV7C30on3UGW+iQSPjlFnJNtQuVuSPdZ3lsvW1BGC7Lxw8m
         87pfw4Sdih/226F7EjpFl5tXS9IK1EjtoNduUBaFTdVLDM8ropWKfs7KDtrNYxkXVhjz
         /AW7tkMZw3MsHGBSJJtwwHWwxcI6UutemnB00v48/0qZLAZPaS+ROys/M+h0xb+NjuC9
         jAhA==
X-Forwarded-Encrypted: i=1; AJvYcCUK1SAy24zeK/kkmTGf3jzOFjZhdbHM7ccyQovGWZLxcVZAyPGS/hsik2J2j89un8rTqCbUVTIWquvxDyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiqqwbjw8/g+jiBrTSVkb5zyLnxjsyeFUOn8OYddX6l8ftejPE
	Hw0SVOGuYt+NaLh0gXtUUK3H4bs1SYXwXaBdxtoDnUamPABjKnHM4OsryHs8pNfXOrltSTPydPg
	3Fly3ca6GgMTlsWgo7hbFLloGeHg6OnU=
X-Gm-Gg: ASbGncvp6bLqGfhQTDB+RQehxttztTu5l4h49OLI8XHguIf/zJLW0cLbbVssjGLdKIU
	KDEGOR+WPJV+7nsWtweYGIfVavbkt3E83i3RTJPBHfI9ICm/gRgUvTnOYPfQ3+x3ab3OA+bkncd
	fo/V0Ot+3qfbXg6E9++nyYGsoPivjGmGGMf6uQRuUIvxtSwLdy27r2vg7BbivSIw7W9T4Az11em
	ysPHMlnWxcCyVp+BWKg93iJfZ/Zzy3Yg6IBGt8=
X-Google-Smtp-Source: AGHT+IGWM1Kap4e+m/WrejLEWP2o8PYUi3RQ+on6TGo8+y8abvoNNR7whNgmd0+FLFUh2eGKY8FYnQXigMolH21LKSA=
X-Received: by 2002:a05:651c:3254:10b0:337:ed76:7067 with SMTP id
 38308e7fff4ca-36418ecc3d6mr989751fa.39.1758218072373; Thu, 18 Sep 2025
 10:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Thu, 18 Sep 2025 23:24:19 +0530
X-Gm-Features: AS18NWBuRfQ-UKCPiS_YSKD2LwE5CmC0UkCJ_avXXnH_mgXZ3W03kcmFYrI4-GY
Message-ID: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
Subject: How are iommu-mappings set up in guest-OS for dma_alloc_coherent
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi everyone.

Let's say we have a following setup :

i)
x86_64 host-os, booted up with iommu enabled and pass-through mode.

ii)
x86_64 guest-os, booted up using vfio+qemu+kvm and a pci-device attached to it.

iii)
A guest-os-device-driver calls "dma_alloc_coherent", after which the
returned dma-address / iova is programmed to the pci-device's
mmio-register.


In the above case, how are the IOMMU mappings set up during the
guest-os-device-driver's "dma_alloc_coherent" call?
Does :

a)
The VMM / KVM intercept the "dma_alloc_coherent" call, and use the
host-iommu to set up things?

OR

b)
There is no interception from VMM / KVM, but rather the guest-OS
itself has a view of the IOMMU (through the regular ACPI tables
populated during guest boot up)?

OR

c)
Anything else under the hood?


Will be grateful for clearing the haze.


Thanks and Regards,
Ajay

