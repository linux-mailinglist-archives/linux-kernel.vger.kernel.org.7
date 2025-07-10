Return-Path: <linux-kernel+bounces-724818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65CAFF740
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908D65A5344
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558C27FD6B;
	Thu, 10 Jul 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGdkGOuN"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640272236F4;
	Thu, 10 Jul 2025 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116615; cv=none; b=SejyvmnJM4vcOpk2fMVaF20HOxb9l1X97NFfRns1REqpfXWzAYNgci5BK3sQDJG58YO3QS/SCJflvuxWjA+Lo0SIKYHDKZ31TL2FI5O/cEbzfqwkJOPYgIV3E0SY4tgjdAi4Swo6BaAQq0HTVRXi2okJuhxGmhHfTct0X3QRxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116615; c=relaxed/simple;
	bh=w1xylG14aNbYICY3r6z4Bte0v6mbpwubDb46q5+D4Ls=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jkqKN+x2Gp7CAf4qLscwIp/GLVe4bvs5iwrbbV555L+ZGl5vfznDr1xp2D6iB1V/9hboyUdByvTguAfUjDmOeCork4hq65rpzFCUryJh7n3f/G98r+tZt+MqgML6G6SOtmQSiYpzaiPv3pnmLT94v13sCVwcHZ6NlLO+96EtqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGdkGOuN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2349f096605so6419125ad.3;
        Wed, 09 Jul 2025 20:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116613; x=1752721413; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAM9TT5oQtsAPqAhej0yrhq8Gvb63FG9Ik+G5Ou/5SM=;
        b=mGdkGOuNJLbUoOR6g/NAIc712uSSv7ru5YHWyPOAXTtkqAIoM8+w3YRaORksVvmS0k
         J/eFMLqWWvd+ykLFkp9kzziNaES+2PlfXoC1lorF1kDdbZZQOAFeVzA70VA6PP8nfxcw
         u1njfijH5zQXuZ0YRDYrlAfemlb0F8B8j9VTunUMmztaYR/zk4Vg7a4cC8+t6xCLioH1
         iMxxUTL4hy3lmOQcBia7qdN4DGapDmBJfIdasaHreuqVNo8r64ABEEK1j/H+QVXJBsp+
         m9YYN48+R6W2yw28Z/XjyeZAQhGvUt92lLO1VI5UbL2vPFv6ntv3dGVsf6ZxU9lHhZXd
         es5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116613; x=1752721413;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAM9TT5oQtsAPqAhej0yrhq8Gvb63FG9Ik+G5Ou/5SM=;
        b=iAu2luQyomlXDWSyiAr+qRBcsUsTLrAJHr+lN9thG9nGzzFPvaNzOAY4yILwQen+Sy
         XwyXYZ4zz2CU9Bk7gf9Bm4J15ZwNGIzHkV5J8IZbY89ROJf/+mAoZqiuSJ5hrlCc9+9v
         f79i5fur++yfWdebcBKOskHcERYR5RKacKS1/Om6SAW9EsmtVlnVwRHgM4N4fGwfqSok
         MM3R0R8r9oLoOOKLqYlAF8djatsdNtBDCB2ZpokADhuL46fn8G0BD0fA9s/5UXWBAXNW
         WnoBn/Nfjklowlj/EtJSSh85WoRrE6zkpRzJPxtbO+e4vbc0Zop3SMwCoyE7VGnY09xj
         Dvlw==
X-Forwarded-Encrypted: i=1; AJvYcCVGaF3M/MOkVOjepDA7sbX70O/QYBba4v391b211WThmgSzbcE9QmyN2MCLkA+dOfXBytJyYtOsW6fJNRk=@vger.kernel.org, AJvYcCXJx7Kye861GKRypUlDhRyWmiL9mxf7U3wHMT+dKowaxC9n6iA+AGJ/BAQbmYx37vinqkgKffXuoR2bB88uO6OamhpnvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/5hca1rHQ2WC/jQKN4+fCCMWPuhYZ/32a9zVjhDKQhw0MSAe
	NGKOiBrlaqQIr//xCuwWQpE1/hhwTbVhirRwgmbtuOCJX9TT5oKEj7Bz
X-Gm-Gg: ASbGncsGZ/NMtiTriCyIsyAhFS9q5evpYRh+G1sURrEqw9aG4RN7OLLZ5Wbs7gnVLwf
	H/FMpLtkaYxSBDzZha+rrYNrKDGhLdwLa1YkOet6c1Ii7RfV9vrWPU4COAjvYEX9sZnPvGlnRPU
	WOiebny7Rl2doiVe9gzH/tiHnUeLGuaF3i8u1TkiRq5mullY+Xu+PgJKoa3cqNz+uiRVMZbGmIN
	ksy6OtfLYXtQOiqE/gqu5yMsbZOgv/OBmTCfIvkILhzhSVFKWmNRaXQPuRWZcbv6lbh/Teg2TnN
	K6iNKKo4c4Xg61T+C5i4aaa6DJnRRro5Sl7SBzAsu2AhEfmOfJ/RAxFvduxt5A==
X-Google-Smtp-Source: AGHT+IHyCn+gm6m8u/SOGtyxPDuAP+8cTWSVOk6V0792+LHW5EyLcD7qCi/yQGYKaFF4xhYa1OTDiA==
X-Received: by 2002:a17:902:ce8e:b0:236:6f7b:bf61 with SMTP id d9443c01a7336-23de4865474mr12392735ad.26.1752116613441;
        Wed, 09 Jul 2025 20:03:33 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm6210445ad.224.2025.07.09.20.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:03:32 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v6 0/6] platform/x86: firmware_attributes_class: Add a high
 level API
Date: Thu, 10 Jul 2025 00:03:15 -0300
Message-Id: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHMtb2gC/13MQW7DIBCF4atErEs1DB5cd9V7VFkMZkiQmjgCy
 00V+e4l6SIuy/ek77+pIjlJUe+7m8qypJKmcx3uZafGI58PolOoWyEggUWn47fmec5F8yVpEOF
 +BETyTlVyyRLT9ZH73Nd9TGWe8s+jvpj7+xciGP6HFqNBI71xlODIR/44nDh9vY7TSd1DC26w6
 RuMFUc27KEjBjO22D6xQ9NgW7ENgUg6Z+3gWtxtsIUGdxUbhm4g9EgUW0xP3AM1mCp24F0gEwY
 rfovXdf0Fi6r7OpwBAAA=
X-Change-ID: 20250326-fw-attrs-api-0eea7c0225b6
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5988; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=w1xylG14aNbYICY3r6z4Bte0v6mbpwubDb46q5+D4Ls=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn5utUu8bZlM09cunz8+j3tI7ZPu15GNJ24Pb9lb1/zm
 VWVovd2dpSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBE5PIZ/rvMjHaYszdl99rd
 7798jJY69Xz2FJXkFQoSq/rN42RWOE9hZJiYcZil8sYTj4DEpPcVixJq1P7eSDzCnK8e6PXI8Wq
 DAAMA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

After my discussion with Joshua on v2, I realized the API I made was not
ergonomic at all and it didn't exactly respond to driver needs. In this
version I tried a completely different approach and IMO it's much much
better now.

First of all I adopted standard sysfs terminology for everything. A
"firmware attribute" is just an attribute_group under the attributes/
directory so everything related to this concept is just called "group"
now. Everything refered as properties in the previous patch are now just
plain "attributes".

This new API revolves around the `fwat_{bool,enum,int,str}_data`
structs. These hold all the metadata a "firmware_attribute" of that
given type needs.

These structs also hold `read` and `write` callbacks for the
current_value attribute, because obviously that value is always dynamic.
However the rest of attributes (default_value, display_name, min, max,
etc) are constant.

In the simple case this metadata structs can be defined statically with
DEFINE_FWAT_{BOOL,ENUM,INT,STR}_GROUP() macros. However most users of
this class obtain this values dynamically so you can also define this
structs dynamically.

In the end all groups (static and dynamic) will be created using
fwat_create_group() after registering the class device.

Let me know what you think, your feedback is very appreciated :)

I do have one question for anyone interested. Should constraints over
the current_value (such as min, max, increment, etc.) be enforced at the
show/store level? i.e. before values reach read/write callbacks.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v6:
  [Patch 1]
    - Add put_device() if device_register() fails
    - Drop sysfs_remove_groups() in fwat_device_unregister()
    - Didn't drop kset_unregister() because I think it's required
  [Patch 2]
    - Introduce FWAT_GROUP_ATTR() macro to avoid errors when creating
      default ktype attributes.
    - Fix typos in firmware_attributes_class.h
    - Constify struct fwat_attribute in callbacks
    - Drop DEFINE_SYSFS_GROUP_VISIBLE() and pass the visibility callback
      directly
    - Drop <linux/list.h> in firmware_attributes_class.h
    - Rename enum fwat_group_type members
    - Move fwat_*_current_value assertions to firmware_attributes_class.c
    - Add a '__' prefix to fwat_create_*_group() functions
    - Some style improvements
    - Didn't drop fwat_remove_auto_groups() because I think it's
      required
  [Patch 4]
    - Don't drop mutex initialization
    - Lock fw_attrs_lock on *_write() callbacks

  - Link to v5: https://lore.kernel.org/r/20250705-fw-attrs-api-v5-0-60b6d51d93eb@gmail.com

Changes in v5:
  - Fix kernel test robot warning
  - Link to v4: https://lore.kernel.org/r/20250630-fw-attrs-api-v4-0-1a04952b255f@gmail.com

Changes in v4:
  [Patch 1]
    - Embbed a device in fwat_device instead of a kobject.
    - Instead of an attrs_kobj root kobj, create a kset with the same
      name.
  [Patch 2]
    - Add a (*show_override) callback in fwat_group_data.
    - Instead of allocating and filling sysfs groups and attributes
      manually, I defined custom ktypes for each fwat type. All groups are
      now statically defined and added through default_groups.
  
      I think this is a BIG optimization in terms of memory at least. Also
      fwat_group memory is now managed by a kobject which is allocated one
      time. This is also a less impactful performance optimization (less
      individual allocations).
    - No changes to API :) (I take suggestions though)

  I might have lost some of the changelog. Sorry for that!
  
  - Link to v3: https://lore.kernel.org/r/20250621-fw-attrs-api-v3-0-3dd55e463396@gmail.com

Changes in v3:
  [Patch 1]
  - Fixed UAF in fwat_device_unregister(). Device was unregistered after
    freeing fadev.
  [Patch 2]
  - Patch 2 was completely replaced. A new approach for the API is taken,
    based on Joshua's suggestions.
  
  - Link to v2: https://lore.kernel.org/r/20250517-fw-attrs-api-v2-0-fa1ab045a01c@gmail.com

Changes in v2:
  [Patch 1]
   - Include kdev_t.h header
  [Patch 2]
   - Use one line comments in fwat_create_attrs()
   - Check propagate errors in fwat_create_attrs()
   - Add `mode` to fwat_attr_config and related macros to let users
     configure the `current_value` attribute mode
   - Use defined structs in fwat_attr_ops instead of anonymous ones
   - Move fwat_attr_type from config to ops
  [Patch 5]
   - Just transition to new API without chaing ABI
  
  - Link to v1: https://lore.kernel.org/r/20250509-fw-attrs-api-v1-0-258afed65bfa@gmail.com

---
Kurt Borja (5):
      platform/x86: firmware_attributes_class: Add high level API for the attributes interface
      platform/x86: firmware_attributes_class: Move header to include directory
      platform/x86: samsung-galaxybook: Transition new firmware_attributes API
      Documentation: ABI: Update sysfs-class-firmware-attributes documentation
      MAINTAINERS: Add FIRMWARE ATTRIBUTES CLASS entry

Thomas Weißschuh (1):
      platform/x86: firmware_attributes_class: Add device initialization methods

 .../ABI/testing/sysfs-class-firmware-attributes    |   1 +
 MAINTAINERS                                        |   8 +
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |   2 +-
 drivers/platform/x86/firmware_attributes_class.c   | 667 ++++++++++++++++++++-
 drivers/platform/x86/firmware_attributes_class.h   |  12 -
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       |   2 +-
 drivers/platform/x86/lenovo/think-lmi.c            |   2 +-
 drivers/platform/x86/samsung-galaxybook.c          | 240 ++------
 include/linux/firmware_attributes_class.h          | 369 ++++++++++++
 9 files changed, 1111 insertions(+), 192 deletions(-)
---
base-commit: 428f6f3a56ac85f37a07a3fe5149b593185d5c4c
change-id: 20250326-fw-attrs-api-0eea7c0225b6
-- 
 ~ Kurt


