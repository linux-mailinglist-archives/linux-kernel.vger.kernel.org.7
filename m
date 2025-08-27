Return-Path: <linux-kernel+bounces-788810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E1B38A95
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F011BA3225
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C62EF678;
	Wed, 27 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtiXuZ1r"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C327144E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324679; cv=none; b=LGv1qXK7DXznwcOQPKu8se//z8xgyr2+0Qr+1XrgwwQGafJjp22p7ByAAhvHuotU71Ns6t5LUtCQY4pBh+VoUbtyOXJcv9HK/O3thvfJSD/QKJDIfllOTC3+VnjA+q8AdA9zLEvofGdgaC1rAJXtsCvuE+5Tvfn3F1t1xqxcCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324679; c=relaxed/simple;
	bh=tqc7EOF5eomKNHHU7yUgg+YlKF5JE4kiwS9b9etUKfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUdXBp0uiDM2BDzRI8wtFaqzQkKAdDVeGuZvIGdZY2jz7V0BMAb+aX/920Iy6dp7vmW3mUNjcN1NmPnJdNJ/7YX7IkYfxTpA/dVgA7DdG6orVKAuduuMuYKUUmXshl0wEsBeP0OuEq5Qz8J2NHr0MYYtzODIeb5JiyJXARLv1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtiXuZ1r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24687bbe3aaso358565ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756324677; x=1756929477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjV0DwmZIW1py3fMx22hVqowrh1QvW3z5IOWwwuGuQ8=;
        b=DtiXuZ1rmD0q+4zoCjXMSFZrbL4mxeYf46N76lFGM2zXCs2vCZIx1Zf1z5XRDz870X
         ZVqEpaCjqTgc7Jk6lZIa/dH4b+zUqL1AMiia2tWIIV5IXQlhnVZNdrv3g6N1XkKvap/l
         xTiPNsROk++xgd2vVyqNiX97wtKUkCy+TUZ4sqoCILwsjHK/rk4FZYBoSZdWKa/MmAD3
         qSKVyGSVhqWwtdZDFTWsbICU4DZbrWxwjOFQbYM323hbABJCw7G/nb8FmKmFmsctEhva
         BmrJRjWMXAamGy0VWdmU2HDOqaHzdjUkhi+Jh1+Pll/htRdhHT6YJWp5N4dFNWeqFTLg
         9rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324677; x=1756929477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjV0DwmZIW1py3fMx22hVqowrh1QvW3z5IOWwwuGuQ8=;
        b=flTwA4PqKs/egqe+WifTDRbdIDLM3v4EPu4jBOihXu8dLjkhGnpnS2zGazBMLOyrfV
         /9jdwHKkNmzyLlknUYzSIJVZujlEipyNaaTiyVLY/AF/t/kYOys4UXHQKdrqsTH9iTNB
         fi3TTPDfXJcOQS5syfmhZXARAI/f3GvPfWYG5QxAqMzUptn0yIAKOZ36cilV1SQhn51W
         AfALKjFpV47tm9HXGjWpN5BYRDUlJFDEOTTuiB729J2ls2pMLKUe8WmsEIjwok4250C+
         BmtGhOw8/aze2SScgcASOoczo90Q43lutRU04RQEUtxk1Wr1SHeRn11oin5b6+5wBZLV
         /4xw==
X-Forwarded-Encrypted: i=1; AJvYcCW6hC42eZ4GdwLZKzcdJDC5mrKWra6MBzxW5gxdoq7c8D679nYkiqgKr5gAYw0U1KQzDlY6CjXJJEtinQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo/Esj1JfT0IoxBX5vRSTiob78WXx6C3cgeugGSf4LN/N0QYWM
	Z1SKz9Ma/qWwpVq/DgJ3zeMj1ef0HF34DyZQ+gj9mL+u7dSrUqbNJaHRHhrqAT/YlZ4jnAJA8Tt
	1lBAUdgsVQFUqEgXhdi5GTVqWKgeQbBw=
X-Gm-Gg: ASbGncsHx0A21RXs/omHxk1qG0bIMMs/xBL0QRgNq5PT0b5tvWB40mf+Ql9tzOZ/K3k
	q7heLc2EQuYhlY7Pssxjy/3DK9Uc5gUWlucDscIPLkx73p0+alYEp70V985QOPWyr5iLFw4cDV6
	zfXFhiR8GnBzBxL9M8d/HHgWFvC+UkSn+Y1FqStKSkg3HTV1Y0C1VUEc+llg7VT1LjSOqOrxL26
	G1IlAU=
X-Google-Smtp-Source: AGHT+IEEV1DocwEWc3jKPYLKt97a8Md11hVsuQXJBA2qHl6dQpH2Wq0GDXOFqg4EKfvaY1b+PH9cdtggpz40TZcPqPY=
X-Received: by 2002:a17:902:c409:b0:248:a01f:a549 with SMTP id
 d9443c01a7336-248a01fa7aamr20750765ad.11.1756324676898; Wed, 27 Aug 2025
 12:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824115051.32988-1-mittalyugansh1@gmail.com>
In-Reply-To: <20250824115051.32988-1-mittalyugansh1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 15:57:45 -0400
X-Gm-Features: Ac12FXxqZBGDhYUXeE_2vpNsyc1MPHvuZvg50t-1nPjCv4vA8bIXi2lV2R6gGM0
Message-ID: <CADnq5_MoWjH2j_VyTEvDmYSKQ2Tfjo-B4som9Fwsb6r_dPo4xA@mail.gmail.com>
Subject: Re: [PATCH] atomfirmware.h: fix multiple spelling mistakes
To: Yugansh Mittal <mittalyugansh1@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Sun, Aug 24, 2025 at 7:28=E2=80=AFPM Yugansh Mittal <mittalyugansh1@gmai=
l.com> wrote:
>
> This patch corrects several typographical errors in atomfirmware.h.
> The fixes improve readability and maintain consistency in the codebase.
> No functional changes are introduced.
>
> Corrected terms include:
> - aligment    =E2=86=92 alignment
> - Offest      =E2=86=92 Offset
> - defintion   =E2=86=92 definition
> - swithing    =E2=86=92 switching
> - calcualted  =E2=86=92 calculated
> - compability =E2=86=92 compatibility
> - intenal     =E2=86=92 internal
> - sequece     =E2=86=92 sequence
> - indiate     =E2=86=92 indicate
> - stucture    =E2=86=92 structure
> - regiser     =E2=86=92 register
>
> Signed-off-by: Yugansh Mittal <mittalyugansh1@gmail.com>
> ---
>  drivers/gpu/drm/amd/include/atomfirmware.h | 30 +++++++++++-----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index 5c86423c2..3d083010e 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -211,7 +211,7 @@ atom_bios_string          =3D "ATOM"
>  };
>  */
>
> -#pragma pack(1)                          /* BIOS data must use byte alig=
ment*/
> +#pragma pack(1)                          /* BIOS data must use byte alig=
nment*/
>
>  enum atombios_image_offset{
>    OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D 0x00000048,
> @@ -255,8 +255,8 @@ struct atom_rom_header_v2_2
>    uint16_t subsystem_vendor_id;
>    uint16_t subsystem_id;
>    uint16_t pci_info_offset;
> -  uint16_t masterhwfunction_offset;      //Offest for SW to get all comm=
and function offsets, Don't change the position
> -  uint16_t masterdatatable_offset;       //Offest for SW to get all data=
 table offsets, Don't change the position
> +  uint16_t masterhwfunction_offset;      //Offset for SW to get all comm=
and function offsets, Don't change the position
> +  uint16_t masterdatatable_offset;       //Offset for SW to get all data=
 table offsets, Don't change the position
>    uint16_t reserved;
>    uint32_t pspdirtableoffset;
>  };
> @@ -453,7 +453,7 @@ struct atom_dtd_format
>    uint8_t   refreshrate;
>  };
>
> -/* atom_dtd_format.modemiscinfo defintion */
> +/* atom_dtd_format.modemiscinfo definition */
>  enum atom_dtd_format_modemiscinfo{
>    ATOM_HSYNC_POLARITY    =3D 0x0002,
>    ATOM_VSYNC_POLARITY    =3D 0x0004,
> @@ -678,7 +678,7 @@ struct lcd_info_v2_1
>    uint32_t reserved1[8];
>  };
>
> -/* lcd_info_v2_1.panel_misc defintion */
> +/* lcd_info_v2_1.panel_misc definition */
>  enum atom_lcd_info_panel_misc{
>    ATOM_PANEL_MISC_FPDI            =3D0x0002,
>  };
> @@ -716,7 +716,7 @@ enum atom_gpio_pin_assignment_gpio_id {
>    /* gpio_id pre-define id for multiple usage */
>    /* GPIO use to control PCIE_VDDC in certain SLT board */
>    PCIE_VDDC_CONTROL_GPIO_PINID =3D 56,
> -  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC swithing =
feature is enable */
> +  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC switching=
 feature is enable */
>    PP_AC_DC_SWITCH_GPIO_PINID =3D 60,
>    /* VDDC_REGULATOR_VRHOT_GPIO_PINID in Gpio_Pin_LutTable, VRHot feature=
 is enable */
>    VDDC_VRHOT_GPIO_PINID =3D 61,
> @@ -734,7 +734,7 @@ enum atom_gpio_pin_assignment_gpio_id {
>  struct atom_gpio_pin_lut_v2_1
>  {
>    struct  atom_common_table_header  table_header;
> -  /*the real number of this included in the structure is calcualted by u=
sing the (whole structure size - the header size)/size of atom_gpio_pin_lut=
  */
> +  /*the real number of this included in the structure is calculated by u=
sing the (whole structure size - the header size)/size of atom_gpio_pin_lut=
  */
>    struct  atom_gpio_pin_assignment  gpio_pin[];
>  };
>
> @@ -997,7 +997,7 @@ enum atom_connector_layout_info_mini_type_def {
>
>  enum atom_display_device_tag_def{
>    ATOM_DISPLAY_LCD1_SUPPORT            =3D 0x0002, //an embedded display=
 is either an LVDS or eDP signal type of display
> -  ATOM_DISPLAY_LCD2_SUPPORT                           =3D 0x0020, //seco=
nd edp device tag 0x0020 for backward compability
> +  ATOM_DISPLAY_LCD2_SUPPORT            =3D 0x0020, //second edp device t=
ag 0x0020 for backward compatibility
>    ATOM_DISPLAY_DFP1_SUPPORT            =3D 0x0008,
>    ATOM_DISPLAY_DFP2_SUPPORT            =3D 0x0080,
>    ATOM_DISPLAY_DFP3_SUPPORT            =3D 0x0200,
> @@ -1011,7 +1011,7 @@ struct atom_display_object_path_v2
>  {
>    uint16_t display_objid;                  //Connector Object ID or Misc=
 Object ID
>    uint16_t disp_recordoffset;
> -  uint16_t encoderobjid;                   //first encoder closer to the=
 connector, could be either an external or intenal encoder
> +  uint16_t encoderobjid;                   //first encoder closer to the=
 connector, could be either an external or internal encoder
>    uint16_t extencoderobjid;                //2nd encoder after the first=
 encoder, from the connector point of view;
>    uint16_t encoder_recordoffset;
>    uint16_t extencoder_recordoffset;
> @@ -1023,7 +1023,7 @@ struct atom_display_object_path_v2
>  struct atom_display_object_path_v3 {
>         uint16_t display_objid; //Connector Object ID or Misc Object ID
>         uint16_t disp_recordoffset;
> -       uint16_t encoderobjid; //first encoder closer to the connector, c=
ould be either an external or intenal encoder
> +       uint16_t encoderobjid; //first encoder closer to the connector, c=
ould be either an external or internal encoder
>         uint16_t reserved1; //only on USBC case, otherwise always =3D 0
>         uint16_t reserved2; //reserved and always =3D 0
>         uint16_t reserved3; //reserved and always =3D 0
> @@ -3547,7 +3547,7 @@ struct atom_voltage_object_header_v4{
>  enum atom_voltage_object_mode
>  {
>     VOLTAGE_OBJ_GPIO_LUT              =3D  0,        //VOLTAGE and GPIO L=
ookup table ->atom_gpio_voltage_object_v4
> -   VOLTAGE_OBJ_VR_I2C_INIT_SEQ       =3D  3,        //VOLTAGE REGULATOR =
INIT sequece through I2C -> atom_i2c_voltage_object_v4
> +   VOLTAGE_OBJ_VR_I2C_INIT_SEQ       =3D  3,        //VOLTAGE REGULATOR =
INIT sequence through I2C -> atom_i2c_voltage_object_v4
>     VOLTAGE_OBJ_PHASE_LUT             =3D  4,        //Set Vregulator Pha=
se lookup table ->atom_gpio_voltage_object_v4
>     VOLTAGE_OBJ_SVID2                 =3D  7,        //Indicate voltage c=
ontrol by SVID2 ->atom_svid2_voltage_object_v4
>     VOLTAGE_OBJ_EVV                   =3D  8,
> @@ -3585,7 +3585,7 @@ struct atom_gpio_voltage_object_v4
>  {
>     struct atom_voltage_object_header_v4 header;  // voltage mode =3D VOL=
TAGE_OBJ_GPIO_LUT or VOLTAGE_OBJ_PHASE_LUT
>     uint8_t  gpio_control_id;                     // default is 0 which i=
ndicate control through CG VID mode
> -   uint8_t  gpio_entry_num;                      // indiate the entry nu=
mbers of Votlage/Gpio value Look up table
> +   uint8_t  gpio_entry_num;                      // indicate the entry n=
umbers of Votlage/Gpio value Look up table
>     uint8_t  phase_delay_us;                      // phase delay in unit =
of micro second
>     uint8_t  reserved;
>     uint32_t gpio_mask_val;                         // GPIO Mask value
> @@ -4507,8 +4507,8 @@ struct amd_acpi_description_header{
>  struct uefi_acpi_vfct{
>    struct   amd_acpi_description_header sheader;
>    uint8_t  tableUUID[16];    //0x24
> -  uint32_t vbiosimageoffset; //0x34. Offset to the first GOP_VBIOS_CONTE=
NT block from the beginning of the stucture.
> -  uint32_t lib1Imageoffset;  //0x38. Offset to the first GOP_LIB1_CONTEN=
T block from the beginning of the stucture.
> +  uint32_t vbiosimageoffset; //0x34. Offset to the first GOP_VBIOS_CONTE=
NT block from the beginning of the structure.
> +  uint32_t lib1Imageoffset;  //0x38. Offset to the first GOP_LIB1_CONTEN=
T block from the beginning of the structure.
>    uint32_t reserved[4];      //0x3C
>  };
>
> @@ -4540,7 +4540,7 @@ struct gop_lib1_content {
>  /*
>    **********************************************************************=
*****
>                     Scratch Register definitions
> -  Each number below indicates which scratch regiser request, Active and
> +  Each number below indicates which scratch register request, Active and
>    Connect all share the same definitions as display_device_tag defines
>    **********************************************************************=
*****
>  */
> --
> 2.43.0
>

