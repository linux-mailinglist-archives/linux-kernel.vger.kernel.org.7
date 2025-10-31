Return-Path: <linux-kernel+bounces-879503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F85C2342F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28BE14E66D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB222A4EE;
	Fri, 31 Oct 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="H5x99lwx"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013A1F5827
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761886100; cv=none; b=bxNrUON0SYFEPnmGnAlCY3d1MerezxhCSihPOILAfozq4Xv/ALBTjmyl0FHr+HHJ9SQHphPFxHVDxd+Sre2aDPLfsaEG4V7+AmOVzEFrelNBSTeElHcewZnrlmupVhZwaEldSCQ27okIP5c/fQVu+38ZrkuZQLo15fZdotgYunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761886100; c=relaxed/simple;
	bh=zAL4Uew2kRkkegj/cOObPY5ATqhKWlz/Yo1+x7xPdR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iQHyuT7zCO/R4bGXWjwOsoxB9Du9Ef4eT0KqJuZUaufFIHrCsL79ugj4tTu/kHw2TBer1Su9SGWQLIg/6wOt/sRwwvSGYci0quQQfOxzxN/I5Z+R8E4kTV8K2yv+aHFAGgNcehE5L2dzLUJ1ec20VzgjupUtB4JGj+PKyK5Ykwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=H5x99lwx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295163ae901so11279005ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1761886098; x=1762490898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+OiTvskOoQU6h9IL752qz8b+0it9yRGV456YrP7vcs=;
        b=H5x99lwxp1wnzzbN6g0HNBEplPKXJb3xXfB+W+URrbCSlVMVb+0/jfCdYNyLleWjux
         jXkchJes8xKGkVHtncDTRMGSTgOEy8wHplerQxg8OV+nepvgdU4Si2AzGfoJZuVuQJzJ
         EiOk6dgkGuDw7GKj3PKCKAtJYy4RW6FGSqd4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761886098; x=1762490898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+OiTvskOoQU6h9IL752qz8b+0it9yRGV456YrP7vcs=;
        b=IWil16iph10AsP+me1BkqRmYoGP5OhcLjc9kJ9Yjvp1/kW874NpRQ2Be2ybm4+BQ8i
         EbE+eCHPE5sNuFNSDGGRQQAfLGyoFYvVkO31dOSSdLWNIXha5RnjV/Nqt217jHvLutPh
         lhkMD66GpzpEBSmTaeJrPq8x0T01IEZiz6y5s3A611eE4ZSRqRYW8EhxkR1p17ns+m7J
         9k27YEP8XbgmusxImmfwT+qYc5lmx5yyIt/Lmhdx5zel0MVhzaxuRaxQoJQ5NnDCvtOO
         /f4z85IzhAaOVh7nTnONJw+tN92ABnCU/2PjRxxuCVOXIFMZs8tRigdC/lmnUAUE7OOP
         bRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVsUDcOpkt/LLLVsrCUlopK/a0VINl//leNwBV9YxSuCxgBGom19cygmYQg7WwhpuJlZ4zv98ld68ZSSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBp/kD56guEOwDQPuM158inFJNFgzNiG9ol7/w/N4tyIhxfEY
	g4/QEeTe31fMNmilyvspKM3pAYWidt1IFmkuX/FaQkdKzv/TRFDMegkLOXD7l/FB9M8=
X-Gm-Gg: ASbGncuy+bclVfSb24tVc60u68BgUid/hE5TYJ5GC3d5wBvk/Ugyc7AyGljkg6NNHYo
	2NAH2IQid6Hveweu36GRXRmUtzyPP/7jh+Sxd9lQnX+20S7yURyua+VBFYb242pR1RsFeFCAAcG
	MM+rqpmh92xtw7aANM6NjLL4zDwHmiDvv5S/MA+5l96nUeBGqQI0LLzZKScM0bJBpNOjTwsMtPE
	hGj4NYGM6UPXLgOe1EAfW+CQFg5gU22T++fDDw9feEVRCDMiwpCS/4bAlilvKBG9hVtirjo3TkM
	x+f7Gpeena1gFUhYXvjBC5ZHnNJXH+/4kY1Qr57pMzpPFv3NiWzIglgTKZ4/LkjwD7zUnzdTmKr
	cK7WvcfwZJWP18HcjumSAU3rkG9I39499JB1eP2z84wraJ0JC/LXf3zjS9zMQSnDusHAvzdTa9A
	2XO9jTEwN2nhoyJAuD6Io8s/nxS4Fg09+yKH7SwQUmCBo4f4eMQcw8H5Y=
X-Google-Smtp-Source: AGHT+IFkuWxI7QfXkeD58QkM1mtzUAeKNOhuO+csBjlMU7CEihxjPiSob7XqSz3c0UNu/gwIGI8ltA==
X-Received: by 2002:a17:903:458d:b0:294:9699:74f6 with SMTP id d9443c01a7336-2951a524d52mr32909245ad.43.1761886098289;
        Thu, 30 Oct 2025 21:48:18 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd2fesm7238875ad.105.2025.10.30.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 21:48:17 -0700 (PDT)
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
Subject: [PATCH v8 0/4] crypto: spacc - Add SPAcc Crypto Driver
Date: Fri, 31 Oct 2025 10:17:59 +0530
Message-Id: <20251031044803.400524-1-pavitrakumarm@vayavyalabs.com>
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
  crypto: spacc - Add SPAcc ahash support
  crypto: spacc - Add SPAcc AUTODETECT Support
  crypto: spacc - Add SPAcc Kconfig and Makefile

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

  v5->v6 changes:
   - Removed CRYPTO_DEV_SPACC_CIPHER and CRYPTO_DEV_SPACC_AEAD Kconfig options,
     since the cipher and aead support is not part of this patchset
   - Dropped spacc_skcipher.o and spacc_aead.o from Makefile to fix build errors
     reported by kernel test robot
   - Added Reported-by and Closes tags as suggested

  v6->v7 changes:
   - Fixed build error reported by Kernel test robot
   - Added Reported-by and Closes tags as suggested

  v7->v8 changes:
   - Fixed misleading comment: Clarified that only HMAC key pre-processing
     is done in software, while the actual HMAC operation is performed by
     hardware
   - Simplified do_shash() function signature by removing unused parameters
   - Updated all do_shash() call sites to use new simplified signature
   - Fixed commit message formatting by adding "crypto: spacc - <subject>" to 
     all patches
   - used __free() for scope based resource management

 .../bindings/crypto/snps,dwc-spacc.yaml       |   50 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/dwc-spacc/Kconfig              |   88 +
 drivers/crypto/dwc-spacc/Makefile             |    8 +
 drivers/crypto/dwc-spacc/spacc_ahash.c        |  962 +++++++
 drivers/crypto/dwc-spacc/spacc_core.c         | 2393 +++++++++++++++++
 drivers/crypto/dwc-spacc/spacc_core.h         |  828 ++++++
 drivers/crypto/dwc-spacc/spacc_device.c       |  275 ++
 drivers/crypto/dwc-spacc/spacc_device.h       |  233 ++
 drivers/crypto/dwc-spacc/spacc_hal.c          |  374 +++
 drivers/crypto/dwc-spacc/spacc_hal.h          |  114 +
 drivers/crypto/dwc-spacc/spacc_interrupt.c    |  328 +++
 drivers/crypto/dwc-spacc/spacc_manager.c      |  613 +++++
 14 files changed, 6268 insertions(+)
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


base-commit: 275a9a3f9b6a2158bfb7826074b72d5bdfb2ac35
-- 
2.25.1


