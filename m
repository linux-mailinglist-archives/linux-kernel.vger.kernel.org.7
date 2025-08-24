Return-Path: <linux-kernel+bounces-783615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDEB32FA8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699AD16B14E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3560274658;
	Sun, 24 Aug 2025 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR8MwLBY"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72391242D69
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036278; cv=none; b=B19455ZI+SUixQoAyiHPPZZWjIu30xdNKkXVrVGmqtgP83aJNvuGlq4bb1pbmOW49hzVF67AzbfHSxRtr1jfCMe/tWhvys+RdAJDq098008syMgWegmMozNBZfhvZEOq0Wd/g52NWS7mqhCT6lvAjysw9zH180S5vmMSk0CiHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036278; c=relaxed/simple;
	bh=kLTzKxX9vaGwPsxpSPjwXLZ+0WI7zEyvDYzlqUQbSQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6UqM7Pz2gDJSztElO4bCCfpR5/URmyiZ8IHBM5BWX8Eit8sqFZ4VASLS0qkFUumULN7zjE0yUhc1SQROcUgbUw+t/25IOJsrnFmu0h4IeSgaTa/csYGQdbIqc/DiNX7h8VyKCxjrkGwlqIeXUKiLyrpmKTRLqbeCPRE4Rckgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR8MwLBY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so3303130b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756036275; x=1756641075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5mPsCzVzELE3GW17tjG44mq7hYqZu6NFHUC+sngu+N0=;
        b=mR8MwLBYSzHlQj4PNoXFEGmVw+dJpYVejlGOUku8ieC8CUPAviMIH2TrfdyLWybp4U
         LGGORjsNrhughCDdsvjveljSHfTzt8LL24tkuxxgqJs86QeMtT8OvylAj2taTkby6aiy
         iXThE2jyBRQeLNDWDPe717F5xqwIwUd8C+wMgTy+Q3295G8GLxdhrAiV8rjZTlJiq0Xm
         V6XXhok3uXB5cYuC4uuQUo9EQ4stc4QYVsrBGwy03rmJRUHUkKllYGxx3WgKT4ttXs1N
         vlO/7zeaKrsCaZ1bwebA0nPWKaOQOi2PAvBxtOBuIc6wQYFHLOCLSq5lFZPvjnyYGRs1
         RZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756036275; x=1756641075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mPsCzVzELE3GW17tjG44mq7hYqZu6NFHUC+sngu+N0=;
        b=btMFO8lVyGUQqjSiUw6Gm4PpH8UiWINi8aCpDwN13220Xdsr4D2YA/MS5FlTOPyQ4m
         t/fKo3X2mOpSHNTIG4kg58HCicLYDZTGAC7Scl/z0MmF1J7wlOMxiuv3rRzwiyvQUrn0
         EVwEVhRRnw7tCqEmlkBui1lSy1L3s9IpcSSWoIaxcRxdkJ9HOTSweDF/p6WZ4F7xFCJ6
         dqpf4aBHKZurtfK4aP2u4QG7JXM0FE4xC0ul5fO1h9szcx8G7WPS1XheiWRjW/10JVEX
         lhsqmczz+gf/MxFsYl5bvkyrH8Dp8dFSsVuFSweiVgdl3qn93qf2GWQhpPdXZlOKKkRY
         heFw==
X-Forwarded-Encrypted: i=1; AJvYcCVe/INDQt/xZro3Yr0MXn4me5F26WKClrf0Eh4iFrLgXkJtlT5n896hmCPiV9+6Ek1e/cOv7rYQQ9b02Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnPcNRBSDyi7sjuodvxDPb3Yo823VFRr+TZKJO1+SqxoZI3ps
	0gghkxGuubrcvJ3qx1qWRupnWke8xQdEch0jpUJ98uBBHc2tSoChqptm
X-Gm-Gg: ASbGncscCnKMhCPhhVYiWepE4bt0znpoaeCDi7gROQzcFVF1RpAZJe5IOo3ymfnZiz4
	8Oigc+gWhLVFUEehZEaSMXaOdTlynDdhnujI8uTRch6V1Xy73t9IdmbWg0KvVGiffGxNjxRb7q8
	SOBfXcHxrEPhvzPcq27QTdWVEBOtWMnIVNV+jiMyyvgjIjTQuWyOqwnUaGffBVF3vE/b8fXB0ED
	i8pg+PAMr0YWP0R+Ib34G+K0+WxKgdJ7dGqF7stsY/FecdukegRHaZ/tFEbZNwdNqyu586IGtTn
	6VdPzEu5x4+kmxJYVt3hV0JCyOwlc4STLUwtcVoEuNTTocQ0xAEhSukJxX2dmrSMNZ5UU/ENA9I
	EaJqALs4LVPQFIBFkWW8HPUeIzkbctoZW4lfRzoSFRPPh1uHHhuU=
X-Google-Smtp-Source: AGHT+IEsTJzNogBKF2aw5fT6u7NYENiRajAD+1opZxqjVK01030T9537BIgwLgexfe99DuG3t4GwSQ==
X-Received: by 2002:a05:6a20:914d:b0:243:78a:8298 with SMTP id adf61e73a8af0-24340e068dfmr14116551637.49.1756036274616;
        Sun, 24 Aug 2025 04:51:14 -0700 (PDT)
Received: from yugansh-Inspiron-14-5410.. ([2401:4900:1c5c:9483:43fb:2a6d:1506:f2f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffed02bsm4550834b3a.24.2025.08.24.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 04:51:14 -0700 (PDT)
From: Yugansh Mittal <mittalyugansh1@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yugansh Mittal <mittalyugansh1@gmail.com>
Subject: [PATCH] atomfirmware.h: fix multiple spelling mistakes
Date: Sun, 24 Aug 2025 17:20:51 +0530
Message-ID: <20250824115051.32988-1-mittalyugansh1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch corrects several typographical errors in atomfirmware.h.
The fixes improve readability and maintain consistency in the codebase.
No functional changes are introduced.

Corrected terms include:
- aligment    → alignment
- Offest      → Offset
- defintion   → definition
- swithing    → switching
- calcualted  → calculated
- compability → compatibility
- intenal     → internal
- sequece     → sequence
- indiate     → indicate
- stucture    → structure
- regiser     → register

Signed-off-by: Yugansh Mittal <mittalyugansh1@gmail.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 5c86423c2..3d083010e 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -211,7 +211,7 @@ atom_bios_string          = "ATOM"
 };
 */
 
-#pragma pack(1)                          /* BIOS data must use byte aligment*/
+#pragma pack(1)                          /* BIOS data must use byte alignment*/
 
 enum atombios_image_offset{
   OFFSET_TO_ATOM_ROM_HEADER_POINTER          = 0x00000048,
@@ -255,8 +255,8 @@ struct atom_rom_header_v2_2
   uint16_t subsystem_vendor_id;
   uint16_t subsystem_id;
   uint16_t pci_info_offset;
-  uint16_t masterhwfunction_offset;      //Offest for SW to get all command function offsets, Don't change the position
-  uint16_t masterdatatable_offset;       //Offest for SW to get all data table offsets, Don't change the position
+  uint16_t masterhwfunction_offset;      //Offset for SW to get all command function offsets, Don't change the position
+  uint16_t masterdatatable_offset;       //Offset for SW to get all data table offsets, Don't change the position
   uint16_t reserved;
   uint32_t pspdirtableoffset;
 };
@@ -453,7 +453,7 @@ struct atom_dtd_format
   uint8_t   refreshrate;
 };
 
-/* atom_dtd_format.modemiscinfo defintion */
+/* atom_dtd_format.modemiscinfo definition */
 enum atom_dtd_format_modemiscinfo{
   ATOM_HSYNC_POLARITY    = 0x0002,
   ATOM_VSYNC_POLARITY    = 0x0004,
@@ -678,7 +678,7 @@ struct lcd_info_v2_1
   uint32_t reserved1[8];
 };
 
-/* lcd_info_v2_1.panel_misc defintion */
+/* lcd_info_v2_1.panel_misc definition */
 enum atom_lcd_info_panel_misc{
   ATOM_PANEL_MISC_FPDI            =0x0002,
 };
@@ -716,7 +716,7 @@ enum atom_gpio_pin_assignment_gpio_id {
   /* gpio_id pre-define id for multiple usage */
   /* GPIO use to control PCIE_VDDC in certain SLT board */
   PCIE_VDDC_CONTROL_GPIO_PINID = 56,
-  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC swithing feature is enable */
+  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC switching feature is enable */
   PP_AC_DC_SWITCH_GPIO_PINID = 60,
   /* VDDC_REGULATOR_VRHOT_GPIO_PINID in Gpio_Pin_LutTable, VRHot feature is enable */
   VDDC_VRHOT_GPIO_PINID = 61,
@@ -734,7 +734,7 @@ enum atom_gpio_pin_assignment_gpio_id {
 struct atom_gpio_pin_lut_v2_1
 {
   struct  atom_common_table_header  table_header;
-  /*the real number of this included in the structure is calcualted by using the (whole structure size - the header size)/size of atom_gpio_pin_lut  */
+  /*the real number of this included in the structure is calculated by using the (whole structure size - the header size)/size of atom_gpio_pin_lut  */
   struct  atom_gpio_pin_assignment  gpio_pin[];
 };
 
@@ -997,7 +997,7 @@ enum atom_connector_layout_info_mini_type_def {
 
 enum atom_display_device_tag_def{
   ATOM_DISPLAY_LCD1_SUPPORT            = 0x0002, //an embedded display is either an LVDS or eDP signal type of display
-  ATOM_DISPLAY_LCD2_SUPPORT			       = 0x0020, //second edp device tag 0x0020 for backward compability
+  ATOM_DISPLAY_LCD2_SUPPORT            = 0x0020, //second edp device tag 0x0020 for backward compatibility
   ATOM_DISPLAY_DFP1_SUPPORT            = 0x0008,
   ATOM_DISPLAY_DFP2_SUPPORT            = 0x0080,
   ATOM_DISPLAY_DFP3_SUPPORT            = 0x0200,
@@ -1011,7 +1011,7 @@ struct atom_display_object_path_v2
 {
   uint16_t display_objid;                  //Connector Object ID or Misc Object ID
   uint16_t disp_recordoffset;
-  uint16_t encoderobjid;                   //first encoder closer to the connector, could be either an external or intenal encoder
+  uint16_t encoderobjid;                   //first encoder closer to the connector, could be either an external or internal encoder
   uint16_t extencoderobjid;                //2nd encoder after the first encoder, from the connector point of view;
   uint16_t encoder_recordoffset;
   uint16_t extencoder_recordoffset;
@@ -1023,7 +1023,7 @@ struct atom_display_object_path_v2
 struct atom_display_object_path_v3 {
 	uint16_t display_objid; //Connector Object ID or Misc Object ID
 	uint16_t disp_recordoffset;
-	uint16_t encoderobjid; //first encoder closer to the connector, could be either an external or intenal encoder
+	uint16_t encoderobjid; //first encoder closer to the connector, could be either an external or internal encoder
 	uint16_t reserved1; //only on USBC case, otherwise always = 0
 	uint16_t reserved2; //reserved and always = 0
 	uint16_t reserved3; //reserved and always = 0
@@ -3547,7 +3547,7 @@ struct atom_voltage_object_header_v4{
 enum atom_voltage_object_mode 
 {
    VOLTAGE_OBJ_GPIO_LUT              =  0,        //VOLTAGE and GPIO Lookup table ->atom_gpio_voltage_object_v4
-   VOLTAGE_OBJ_VR_I2C_INIT_SEQ       =  3,        //VOLTAGE REGULATOR INIT sequece through I2C -> atom_i2c_voltage_object_v4
+   VOLTAGE_OBJ_VR_I2C_INIT_SEQ       =  3,        //VOLTAGE REGULATOR INIT sequence through I2C -> atom_i2c_voltage_object_v4
    VOLTAGE_OBJ_PHASE_LUT             =  4,        //Set Vregulator Phase lookup table ->atom_gpio_voltage_object_v4
    VOLTAGE_OBJ_SVID2                 =  7,        //Indicate voltage control by SVID2 ->atom_svid2_voltage_object_v4
    VOLTAGE_OBJ_EVV                   =  8, 
@@ -3585,7 +3585,7 @@ struct atom_gpio_voltage_object_v4
 {
    struct atom_voltage_object_header_v4 header;  // voltage mode = VOLTAGE_OBJ_GPIO_LUT or VOLTAGE_OBJ_PHASE_LUT
    uint8_t  gpio_control_id;                     // default is 0 which indicate control through CG VID mode 
-   uint8_t  gpio_entry_num;                      // indiate the entry numbers of Votlage/Gpio value Look up table
+   uint8_t  gpio_entry_num;                      // indicate the entry numbers of Votlage/Gpio value Look up table
    uint8_t  phase_delay_us;                      // phase delay in unit of micro second
    uint8_t  reserved;   
    uint32_t gpio_mask_val;                         // GPIO Mask value
@@ -4507,8 +4507,8 @@ struct amd_acpi_description_header{
 struct uefi_acpi_vfct{
   struct   amd_acpi_description_header sheader;
   uint8_t  tableUUID[16];    //0x24
-  uint32_t vbiosimageoffset; //0x34. Offset to the first GOP_VBIOS_CONTENT block from the beginning of the stucture.
-  uint32_t lib1Imageoffset;  //0x38. Offset to the first GOP_LIB1_CONTENT block from the beginning of the stucture.
+  uint32_t vbiosimageoffset; //0x34. Offset to the first GOP_VBIOS_CONTENT block from the beginning of the structure.
+  uint32_t lib1Imageoffset;  //0x38. Offset to the first GOP_LIB1_CONTENT block from the beginning of the structure.
   uint32_t reserved[4];      //0x3C
 };
 
@@ -4540,7 +4540,7 @@ struct gop_lib1_content {
 /* 
   ***************************************************************************
                    Scratch Register definitions
-  Each number below indicates which scratch regiser request, Active and 
+  Each number below indicates which scratch register request, Active and
   Connect all share the same definitions as display_device_tag defines
   *************************************************************************** 
 */   
-- 
2.43.0


