Return-Path: <linux-kernel+bounces-834182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1EDBA4208
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C906E1C056B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813182F99AD;
	Fri, 26 Sep 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="HCmIdGLg"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3352309BE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896366; cv=none; b=gAVQ+Vwc72xRUvxCl+9R2GGg6HzDp69kDfw/gYGkoIUB03r5giHplDhZ5nC7HRq3we3wLL00Ma8/c5N6+zZoYLmJ8K1HaLiEWP2bSY7oTztQFSMPm4DS1idCMRqoAyTyubynPXD3oP5nqzffTgB4JKlZw6QYk4Ex4yrkZ2Sf6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896366; c=relaxed/simple;
	bh=qvArYMpECQWNjBPgOxirpmiiPvoUDMcIKMOCAFvgia0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DI/gAEhr/tCUEm2rzvNZpayZrHtmSfA7WpUkGUBBpFBJbYJPOGrYNpeyWr29ezWHes1cIRsLLq/rU5QyvsJ+4/3dm/ZuvfXKYEmW9/nsgZg3BswYr5fOMfVhWcNNZUnmMFix+Vfn5vw5OjQ//j2jIVqXkyMybTd2FMUQMUFs2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=HCmIdGLg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781010ff051so1585148b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1758896363; x=1759501163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a15yEDQ1T2kumn6gYn6T3lQRGJS4ns0sEIC2Qbr0Jig=;
        b=HCmIdGLg0oVNGQ3tCXmQt72rHBTNTPQoEZRpuyAE8QPxquF6wwOQw4PQ1F3FSyhkYS
         YUsKByiZvNJYwOET+DDE89MoACNPvBlFR7Z9wpDmHkBwNBA6HTHmWgAC/SzmRp5ASTSh
         dhypQ3iNyCmOqi6zIGNM7h5yNG893pslkcI0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896363; x=1759501163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a15yEDQ1T2kumn6gYn6T3lQRGJS4ns0sEIC2Qbr0Jig=;
        b=uRey+EfY/aY47E/NXO2kfZZlGKK7/Cuf8vIpfacAY9uIWs3QHGMetTijL/blwPugy+
         dtEthwiGD+mzlg4sGTdwpbG9MeTacEB3Rv6Z+0RuqtTuWltDXDFp/nGl61GAU6vQED4I
         P8QdXyNTSPT/Ix0/fT+X0jB7VMcfnwsnRuXpDfgxxnoXzGDl/6ezVrzhCjsUfUPxq4gW
         pyuUcw4ZvhBT8UeR5PuYY7LnHwiTLGdY899MJ3xKmeNRwUpDWYwbR9TZVg6wYjRfEOTY
         eXk5Zy1YQ2dd1qmiGT8kZlhBsIvoXBtBfqSwsaDSCyLQeBcsJWYwuHmVrSlXbSjkLcLU
         skTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV33ky/ff/aNZvVunaDatcBgVJo2X7ihkHrBTtUpT7jkKdG7DDpLfhpKktYDPEUr8CA7zivUBWQMGAQsyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIaO5T75gkhOseBQZAM6k37PeJ7+j9TkM1izNqouGF7HkVC0pn
	5KwsMt0skHoKNRCPSBEjMgZiOE3r7nZkuglilmq29udvpzRZ8uUd3gLn1yWQux1vrw0=
X-Gm-Gg: ASbGnctTQjUi5ujI76RIlZZCJ3kQIWiqE6JfclG+eiMpH/HsiKomNfqV6ebkWheiDjH
	t06O9OjTejxxQLfU608H/UCUxvEztIcC19mwajKEaww5X9MTxGuYFYh0KiAyS2BVnl+Y7F337nY
	d5J2PwHv30RPEogc3JLQZb0v58J491vjrqVD8d+tlsLs68KeBKYOChjkhsu559ec7rAaKnE6UlR
	sMAQbXt+94exq9Ii0Mdh+KSChf2nMLQCQ6l9nLF1/XI1TCubHbPPhSZR0fXyGvUMq//lKyV3+QO
	2xCKbv6/4bfzsUnhgT5LG3HOSFm6typAoKUOmV1uAPj+3dMFlqRPbpsgoMF58wz3TVn9pz6T2mO
	U1Xo/hT/Urvi6KCq+TyZ/FKmXoMjNHNKnaSsKJd9F/kLawg==
X-Google-Smtp-Source: AGHT+IFZ16FT1p5gokWgr6LpHsUm5GTcBBHq5fPgHU1wdmqAqjrcfBJ/8H4l2VH5+fHKS9me61FR7w==
X-Received: by 2002:a05:6a00:139e:b0:781:2271:50ed with SMTP id d2e1a72fcca58-7812271540fmr530653b3a.5.1758896363226;
        Fri, 26 Sep 2025 07:19:23 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238ca1esm4624845b3a.11.2025.09.26.07.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:19:22 -0700 (PDT)
From: Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
To: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	herbert@gondor.apana.org.au,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ruud.Derwig@synopsys.com,
	manjunath.hadli@vayavyalabs.com,
	adityak@vayavyalabs.com,
	Pavitrakumar Managutte <pavitrakumarm@vayavyalabs.com>
Subject: [PATCH v5 0/4] Add SPAcc Crypto Driver
Date: Fri, 26 Sep 2025 19:49:00 +0530
Message-Id: <20250926141904.38919-1-pavitrakumarm@vayavyalabs.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the driver for SPAcc(Security Protocol Accelerator), which is a             
crypto acceleration IP from Synopsys. The SPAcc supports multiple ciphers,      
hashes and AEAD algorithms with various modes. The driver currently supports    
below                                                                           
                                                                                
hash:                                                                           
- cmac(aes)                                                                     
- xcbc(aes)                                                                     
- cmac(sm4)                                                                     
- xcbc(sm4)                                                                     
- hmac(md5)                                                                     
- md5                                                                           
- hmac(sha1)                                                                    
- sha1                                                                          
- sha224
- sha256                                                                        
- sha384                                                                        
- sha512                                                                        
- hmac(sha224)                                                                  
- hmac(sha256)                                                                  
- hmac(sha384)                                                                  
- hmac(sha512)                                                                  
- sha3-224                                                                      
- sha3-256                                                                      
- sha3-384                                                                      
- sha3-512                                                                      
- hmac(sm3)                                                                     
- sm3                                                                           
- michael_mic                                              

Pavitrakumar Managutte (4):
  dt-bindings: crypto: Document support for SPAcc
  Add SPAcc ahash support
  Add SPAcc AUTODETECT Support
  Add SPAcc Kconfig and Makefile

changelog:
  v1->v2 changes:
    - Added local_bh_disable() and local_bh_enable() for the below calls.
      a. for ciphers skcipher_request_complete()
      b. for aead aead_request_complete()
      c. for hash ahash_request_complete()
    - dt-bindings updates
      a. removed snps,vspacc-priority and made it into config option
      b. renamed snps,spacc-wdtimer to snps,spacc-internal-counter
      c. Added description to all properties
    - Updated corresponding dt-binding changes to code 

  v2->v3 changes:
    - cra_init and cra_exit replaced with init_tfm and exit_tfm for hashes.
    - removed mutex_lock/unlock for spacc_skcipher_fallback call
    - dt-bindings updates
     a. updated SOC related information
     b. renamed compatible string as per SOC
   - Updated corresponding dt-binding changes to code 

  v3->v4 changes:
   - removed snps,vspacc-id from the dt-bindings 
   - removed mutex_lock from ciphers
   - replaced magic numbers with macros
   - removed sw_fb variable from struct mode_tab and associated code from the
     hashes
   - polling code is replaced by wait_event_interruptible

  v4->v5 changes:
   - Updated to register with the crypto-engine
   - Used semaphore to manage SPAcc device hardware context pool
   - This patchset supports Hashes only 
   - Dropping the support for Ciphers and AEADs in this patchset 
   - Added Reviewed-by tag on the Device tree patch since it was reviewed on 
     v4 patch by Krzysztof Kozlowski and Rob Herring (Arm)

 .../bindings/crypto/snps,dwc-spacc.yaml       |   50 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/dwc-spacc/Kconfig              |  114 +
 drivers/crypto/dwc-spacc/Makefile             |   16 +
 drivers/crypto/dwc-spacc/spacc_ahash.c        |  980 +++++++
 drivers/crypto/dwc-spacc/spacc_core.c         | 2394 +++++++++++++++++
 drivers/crypto/dwc-spacc/spacc_core.h         |  830 ++++++
 drivers/crypto/dwc-spacc/spacc_device.c       |  301 +++
 drivers/crypto/dwc-spacc/spacc_device.h       |  233 ++
 drivers/crypto/dwc-spacc/spacc_hal.c          |  374 +++
 drivers/crypto/dwc-spacc/spacc_hal.h          |  114 +
 drivers/crypto/dwc-spacc/spacc_interrupt.c    |  328 +++
 drivers/crypto/dwc-spacc/spacc_manager.c      |  613 +++++
 14 files changed, 6349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/snps,dwc-spacc.yaml
 create mode 100644 drivers/crypto/dwc-spacc/Kconfig
 create mode 100644 drivers/crypto/dwc-spacc/Makefile
 create mode 100644 drivers/crypto/dwc-spacc/spacc_ahash.c
 create mode 100644 drivers/crypto/dwc-spacc/spacc_core.c
 create mode 100644 drivers/crypto/dwc-spacc/spacc_core.h
 create mode 100644 drivers/crypto/dwc-spacc/spacc_device.c
 create mode 100644 drivers/crypto/dwc-spacc/spacc_device.h
 create mode 100644 drivers/crypto/dwc-spacc/spacc_hal.c
 create mode 100644 drivers/crypto/dwc-spacc/spacc_hal.h
 create mode 100644 drivers/crypto/dwc-spacc/spacc_interrupt.c
 create mode 100644 drivers/crypto/dwc-spacc/spacc_manager.c


base-commit: b73f28d2f847c24ca5d858a79fd37055036b0a67
-- 
2.25.1


