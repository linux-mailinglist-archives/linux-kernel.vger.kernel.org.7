Return-Path: <linux-kernel+bounces-843836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5D6BC0602
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA273AFCC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282A22A7E0;
	Tue,  7 Oct 2025 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="GwDAa8UH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72F215767
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819839; cv=none; b=KqK+wfJHRCcjT+3BLWQyRYHBc8Lz5btcHRYRh57TmAYE0cuM7hBzXuMKdTbNmBqsKrELNMUqpMsqGezK9kyF6c9BJFly6uaAeBFbKi0phWZoj7m4UZixPxmID4caNk3ie8Z9zdPsrIcy7b/b2VlvTUW1ri7Xo2IXuWTDrYtV8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819839; c=relaxed/simple;
	bh=QnTLV3o19IG6q9YeHZebGR923u5V9mmkqGyVmvzfLc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SWv+bxUeDhNOnRirxSXKBfUfEITbbV6o1pAP2HkHnpLHYgWj+vTBlYiDuMGasmITQOcAoAv6jd555SLwh56kopJNQ+EZ57YZojvqcn3LcQ2k6aLEjed2bJgBCDUkVRIrDAZjlmUbCGxlOoEzpfFVrXcKYQmkZr9znL5KigOL8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com; spf=pass smtp.mailfrom=vayavyalabs.com; dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b=GwDAa8UH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vayavyalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vayavyalabs.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-269af38418aso71498945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vayavyalabs.com; s=google; t=1759819837; x=1760424637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ue3YLt56/lr86Z7z674epKcb+OTcReM8+sZPVWTsKU=;
        b=GwDAa8UHYRjEi52ycFVQ04djnMFU4iM3bQU46XZVynA8kB1fsZI+V72Zq+STjkjofn
         BMVYvtrQNKpdhm5VumSmUalNa6uQ1jLAm2T2ynYbOOTxwAOXmSZm7qZ972TLN2I6dOSF
         W/MaV4tkmWOEigTefoaI7d7r9wyZ3+FKxKxAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819837; x=1760424637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ue3YLt56/lr86Z7z674epKcb+OTcReM8+sZPVWTsKU=;
        b=VBTgkdDhhJZy4bDZbv5WQ29VdHHPaCHgqbqol+7PUgU7vdykdeJHUjvhDWh0LE9QHZ
         i8R3nQbYkf3z7iDXRetz2VwR3ZcdeRMMTb0LLUv1NQ933Y8XwTXzazUggqh2q2/163Th
         W9szwmM5U4MQKOwTefRdYwPWC/p5WN4+xQcoO4tG7aEHSjVDgitVy5KRoL76jP1VpfTK
         NvqeVMPURTtxzY9zd7V8abC4iIDHgKYsABh2q16mYAtHiPv7s8sLhDoLS/baNg1xdI4w
         RrDucMsgAUGHB1EZfAGGQbpLbbsr2pf4EEraVpSu3Fh+mK/DIdMXLyergHHGjaNmjRbS
         JaeA==
X-Forwarded-Encrypted: i=1; AJvYcCWR67JGiUUzUwHkUYF/4DIDj0IJvQw79n5sK1xMwrltaIj1DY9B5cbinnHfkcGqpusTZ/3XRTXerM9M7cE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sSosUWJuX6Jw6j1zKirLqnnwBa8SUC41FYJ7+BsV6O58oZR2
	ZMom4ZMeXqjvAHo142PavseXf/4CcsOsN+UsuGO0C+yWwewKf8Mz7bO/tph1+aOwT5I=
X-Gm-Gg: ASbGncu1iPiH2K55+ZIhqYUpOVnB8LZbuSqjIOHy2WPWWZ1IVEIQGCaJFLsCTw0VIM1
	Hhqychun+k77SgXfSAp42DKfTw8JG2W3WRoZpFjEp+7es0GDo1Qo8C7moWgcQ0XUZsglWm9PBkR
	T2ZYCYpJnrDh5Ha9AElNXLOE2mAlCroK645Cdf36D9xSnOQLH/7ZvIpK9al7S23wg6fwEchcptd
	JzWEwPgaCUBF+I3LMXnp5IW+zD3siY5Bv8Nqx+6kncgJGQxFCborZqrm+MZmEzRDMl4sjsenqqr
	IyybIMMqllsFIOLFd8O/xw/kIzJtkV7IzqXmNNbsZ+tg///E72yHpnjsgatKWT9j+v5DDCSM/hb
	+osVgJPl2IlguyLHbSkfuSb/G+a2JuE1wi0DYz+Tq3MmHLyvZYIHCFPIJdkDpscRafsYLmw==
X-Google-Smtp-Source: AGHT+IGyuOfQcD629SA8YXpzQqVGAaDQkA881473yXUv9GAx21Pra7oLfp+Z5y2AIx6o3w56Q0/m5A==
X-Received: by 2002:a17:903:3bcf:b0:273:1516:3ed2 with SMTP id d9443c01a7336-28e9a6dd480mr172564515ad.50.1759819837084;
        Mon, 06 Oct 2025 23:50:37 -0700 (PDT)
Received: from localhost.localdomain ([103.108.57.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111905sm153287745ad.24.2025.10.06.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 23:50:36 -0700 (PDT)
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
Subject: [PATCH v7 0/4] Add SPAcc Crypto Driver
Date: Tue,  7 Oct 2025 12:20:16 +0530
Message-Id: <20251007065020.495008-1-pavitrakumarm@vayavyalabs.com>
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
     reported by kernel test robot
   - Added Reported-by and Closes tags as suggested

  v6->v7 changes:
   - Fixed build error reported by Kernel test robot
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


base-commit: c0d36727bf39bb16ef0a67ed608e279535ebf0da
-- 
2.25.1


