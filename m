Return-Path: <linux-kernel+bounces-835894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5A9BA8468
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC9316804B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312842C0290;
	Mon, 29 Sep 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="SOzTMCuF"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD062571B8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131838; cv=none; b=NVO+EC+SHFnGYkHYjkXaTnyaU/yYnDjJ65f+PyK9yVpzM89nYmSh61ucnBQFLga9piGZhWlyZW9c1081ogtKyoaOrtEA92x1YIkQKZYVaQIqs/550YvFnzodFwNrvm7KCoyFhHsDFPs+pVypaNJJ4xoxKcH51LbXRLRPnC0HBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131838; c=relaxed/simple;
	bh=VXI1szOjiKjEL8zYBGVQtWD6/5ILKOW18W82tAcfKjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5xf6mPvbe95cUEPEiq4hVQ20Eyqp5QUYIc6mSIz83/ryHx8exexiUZPCrRBe+1w6vV0kgtTe58R2KVqEKIpdSEPP2cipr8vvqGvgpDXOm9yP023yb755H7mPmxwteAWEyUnNiu5zuN9/sjzjfNmhZzY7MNNqqcuLYwFvikI4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=SOzTMCuF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26e68904f0eso42513285ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1759131836; x=1759736636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkzwN7LTL6uCgBrStY6yDcslORDO/lWty4C23MUHWAI=;
        b=SOzTMCuFxKjZRIgr6MqrE9n03uWTDOmWiEUiSUQ97Uae1YoaJLyeVxMg2vU9SXBOq0
         +aedJHA5WdaDNsbL+/qnItG6YS1kf/uAB34zLIUxPRu3aRPfisButG8QFt0vqVGr4e1H
         i+JWRqP7UhUR4SROAlfmqe/rFqL8lfx1nDC64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759131836; x=1759736636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkzwN7LTL6uCgBrStY6yDcslORDO/lWty4C23MUHWAI=;
        b=Ufp/eJN3R1z0qxsxI+xBKT9mVk8yEdDL6b9VEys3qf8mRWr0by3kl4oAjz535DZIx+
         bK8NCCJvl3ZzVWFyR0jZSA5PiY0NL0C9d5WcLMSnADq/Zo9sM+ehPliM1eWpg5cUJ+tx
         hoOllQjXNhy7S4mODj6E4YA5aFDUx7AqbHncnOWpO/RmqhCcP0KWd1EN12TFrzvznWgD
         TwsEfhIxjPPxYXsvnaBPIO0EO0Ig3e3o9pob6CGt3B3h0l8/EvUAWVeF4iTr/qTjy0Ah
         /k4w5dvn1xBiy4OhJj9EvhOadrzH6CSh61W4G6d1uxoYDOPVDZZPw24lRxNorCaE8Xy3
         fIOw==
X-Forwarded-Encrypted: i=1; AJvYcCU3X7XvroQ8DXoQXzTxR44IApiWYkZvd608/frWcCaUu3m9eoMkzFrBa07MpnA5JF8gw6xjLLdwHI37f7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEKGXQ9i0l6jnL4VkSOw1+koAVES7SFnzJhm2nWOWRKXp0xR7
	EHp693WC/Fyjey3yZczPNr+wUZWWOT38UefuUkLdz0/2kcVoK9+QtWfxQAd1aUmSOBA=
X-Gm-Gg: ASbGncsRkiQ8hPq/zlIzCtAwi9GGlb8fsrOWEIXtTFU+6OWmyoPs/ZbP167k1LOJptU
	dvK/7U6OCyXSRuBdGzJqFHfasyOkgO04LGcns6Iu1R0EgBKFxCi9ldbAp1IttFuAwXCsX0nC+2H
	jsG6J1+5D0dL/OZ9Zgk5Q4eZ4+fDnpSI/oCT877aWKgKm/20Bpk9t1MyaBvFIFu2w5Zc9V1H7BK
	pHTByDv79K84Z+qRKRnpWv6DZOWO6uUkrawmDULzKB6ricO6H6YWDOZePa3ef6F/FLuA7e+8JiC
	ODUqcN9TJpYWUC5zX21yK3iyWK7sCoLFz909dCSH7ZUZijC/O+vFf/CmnO0R3/miI860F8Cw/Oj
	ZXRJtg3gR3nnj0EcXHZ4k3LEYk/J0gQC8Qou5sglaQWUR0bM6R+Ho6WcE
X-Google-Smtp-Source: AGHT+IH5ltnVhI8p9SWMfpRx11EhtJiGOK7ftW/7FfXvSgTjSgVPvPELvNXl5zpk2IS2lmwtKYpJEQ==
X-Received: by 2002:a17:902:e5c7:b0:24b:1589:5054 with SMTP id d9443c01a7336-27ed4a29670mr159434275ad.23.1759131836048;
        Mon, 29 Sep 2025 00:43:56 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bc273sm121341105ad.124.2025.09.29.00.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:43:55 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Add SPAcc Crypto Driver
Date: Mon, 29 Sep 2025 13:13:30 +0530
Message-Id: <20250929074334.118413-1-pavitrakumarm@vayavyalabs.com>
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

  v5->v6 changes:
   - Removed CRYPTO_DEV_SPACC_CIPHER and CRYPTO_DEV_SPACC_AEAD Kconfig options,
     since the cipher and aead support is not part of this patchset
   - Dropped spacc_skcipher.o and spacc_aead.o from Makefile to fix build errors
     reported by kerenel test robot
   - Added Reported-by and Closes tags as suggested

 .../bindings/crypto/snps,dwc-spacc.yaml       |   50 +
 drivers/crypto/Kconfig                        |    1 +
 drivers/crypto/Makefile                       |    1 +
 drivers/crypto/dwc-spacc/Kconfig              |   80 +
 drivers/crypto/dwc-spacc/Makefile             |    8 +
 drivers/crypto/dwc-spacc/spacc_ahash.c        |  980 +++++++
 drivers/crypto/dwc-spacc/spacc_core.c         | 2394 +++++++++++++++++
 drivers/crypto/dwc-spacc/spacc_core.h         |  830 ++++++
 drivers/crypto/dwc-spacc/spacc_device.c       |  283 ++
 drivers/crypto/dwc-spacc/spacc_device.h       |  233 ++
 drivers/crypto/dwc-spacc/spacc_hal.c          |  374 +++
 drivers/crypto/dwc-spacc/spacc_hal.h          |  114 +
 drivers/crypto/dwc-spacc/spacc_interrupt.c    |  328 +++
 drivers/crypto/dwc-spacc/spacc_manager.c      |  613 +++++
 14 files changed, 6289 insertions(+)
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


base-commit: 166c83f7789ed02dc1f25bc7bed4a1beb25343aa
-- 
2.25.1


