Return-Path: <linux-kernel+bounces-883006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9659C2C3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17863189263E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEBB275111;
	Mon,  3 Nov 2025 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvhdCcDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F6269D17
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177656; cv=none; b=XSNWxTaZRP2vLrw6IFntXTo4hHr09mWY1TeNer84T3BoFscMSkW9mSWj5Kcadl2S1v8S9zm40xKlJj1DawmKKUuVB9LrM9WerQi++QmveB8rxE+3PlkD2QGCd9sg+KObkEDXAqNN/FlwFebWwron66d2SnjmRBgZeyLdPF7QrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177656; c=relaxed/simple;
	bh=j7KXt+0qwa6Oysi3rZC11fOb0Go3MJ1KImzAUkZcldo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD29946pd8Al+DaTE+DlBn/bH0zLZxL88/nbtzlzgl473pbYwiKHhmAWqSpQEYuYfW0a5CcxfxxYIlegRpqdkbUHwhHvEfr6WHtNuzjlI1g+HHGHaz0X8voOJe+RTAIDPr0HoRq2bvke0EzvUY+jePsEOiwYRKbWYBEoUjZiAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvhdCcDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D3CC4AF0B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762177656;
	bh=j7KXt+0qwa6Oysi3rZC11fOb0Go3MJ1KImzAUkZcldo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lvhdCcDPRc+jeD7J/gCj2hvD5RebTdYeqVzfkjNBY2xhHeWVJRRmgI15G4nQv7VoK
	 paQRuTU0yo9M1+SB0iHDorTk1E32PBjoiwlTfmyrZzx8w3OLNSv6H7kusECp1tsKuM
	 pPgMc5nGPRERma9gjEAw8psriMx9xn3e1Tf4PhULZILvv2wf3G4WwEdYOGyyNmCuQB
	 hrGHNbx8fjvryyJvxUpWHXjUDaRVV7zt8AvguNpJQ/b48Mbcnj7godzuy7RnA9+yJd
	 TLhht/DE2me7BSS3Bh/faRQwtTO5cJ/L8niF0zQPoKzF9JEEbZ2P6MA+ern0SYOj6V
	 ApULL/yAuBe9g==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37a34702a20so10464841fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:47:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWP2UrHAxVCs+fr1Ndg4a4nikopwRosHqDdQZfRe5JQql6ECpLcbQoGC3HnqZAOaoCd6mMaldDXO6nTIrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqNxD6zlliqC+isP2EvTV18l0sxK9B247jQYZwnAH5ZCIB/6W
	qgBdXAPlJZp4PPiHVVXuln8VdBaYe8cCJvJz1pe7zohIC5Kx1Nr8iUm5s6atoAHm1PVpNmxEUjJ
	aeeHsmFXcfR7fMexge1UhDMpe8WrKoJQ=
X-Google-Smtp-Source: AGHT+IFgi/OunRqwG2MPqdDE0aQ6CMLn/DkX/gJimR1rnYl9Ueya7htfn9wwaISdNJKG0beGpdP2LmVTnwIOjoYIrDM=
X-Received: by 2002:a05:651c:1549:b0:37a:3422:bb61 with SMTP id
 38308e7fff4ca-37a3422bbdemr12450271fa.37.1762177654748; Mon, 03 Nov 2025
 05:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103123335.1089483-1-francescopompo2@gmail.com>
In-Reply-To: <20251103123335.1089483-1-francescopompo2@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 3 Nov 2025 14:47:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHO8Mxk+zPEwx2+VP1FF_LoDu58tbDOm+-Y8m07d3nitw@mail.gmail.com>
X-Gm-Features: AWmQ_bmGMQyq1UXYc2c_M7tkautGQpJUnj4QLKm77mxzQOvVEesb5ICGXsnUmgs
Message-ID: <CAMj1kXHO8Mxk+zPEwx2+VP1FF_LoDu58tbDOm+-Y8m07d3nitw@mail.gmail.com>
Subject: Re: [PATCH v2] efistub/x86: Add fallback for SMBIOS record lookup
To: Francesco Pompo <francescopompo2@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 13:33, Francesco Pompo <francescopompo2@gmail.com> wrote:
>
> Some Apple EFI firmwares do not provide the SMBIOS Protocol,
> causing efi_get_smbios_record() to fail. This prevents retrieval of
> system information such as product name, which is needed by
> apple_set_os() to enable the integrated GPU on dual-graphics Intel
> MacBooks.
>
> Add a fallback that directly parses the SMBIOS entry point table when
> the protocol is unavailable.
>
> Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c | 107 +++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
>

OK, I've pushed this to the efi/next branch now. I did apply some
cosmetic tweaks, though, so please double check that I did not break
anything.


> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index f8e465da344d..13059412fdb9 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -225,6 +225,110 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
>         }
>  }
>
> +struct smbios_entry_point {
> +       char anchor[4];
> +       u8 ep_checksum;
> +       u8 ep_length;
> +       u8 major_version;
> +       u8 minor_version;
> +       u16 max_size_entry;
> +       u8 ep_rev;
> +       u8 reserved[5];
> +       char int_anchor[5];
> +       u8 int_checksum;
> +       u16 st_length;
> +       u32 st_address;
> +       u16 number_of_entries;
> +       u8 bcd_rev;
> +};
> +
> +static bool verify_ep_checksum(const struct smbios_entry_point *ep)
> +{
> +       const u8 *ptr = (u8 *)ep;
> +       u8 sum = 0;
> +       int i;
> +
> +       for (i = 0; i < ep->ep_length; i++)
> +               sum += ptr[i];
> +
> +       return sum == 0;
> +}
> +
> +static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
> +{
> +       const u8 *ptr = (u8 *)&ep->int_anchor;
> +       u8 sum = 0;
> +       int i;
> +
> +       for (i = 0; i < 15; i++)
> +               sum += ptr[i];
> +
> +       return sum == 0;
> +}
> +
> +static bool verify_ep_integrity(const struct smbios_entry_point *ep)
> +{
> +       if (memcmp(ep->anchor, "_SM_", sizeof(ep->anchor)) != 0)
> +               return false;
> +
> +       if (memcmp(ep->int_anchor, "_DMI_", sizeof(ep->int_anchor)) != 0)
> +               return false;
> +
> +       if (!verify_ep_checksum(ep) || !verify_ep_int_checksum(ep))
> +               return false;
> +
> +       return true;
> +}
> +
> +static const struct efi_smbios_record *search_record(void *table, u32 length,
> +                                                    u8 type)
> +{
> +       const u8 *p, *end;
> +
> +       p = (u8 *)table;
> +       end = p + length;
> +
> +       while (p + sizeof(struct efi_smbios_record) < end) {
> +               const struct efi_smbios_record *hdr =
> +                       (struct efi_smbios_record *)p;
> +               const u8 *next;
> +
> +               if (hdr->type == type)
> +                       return hdr;
> +
> +               /* Type 127 = End-of-Table */
> +               if (hdr->type == 0x7F)
> +                       return NULL;
> +
> +               /* Jumping to the unformed section */
> +               next = p + hdr->length;
> +
> +               /* Unformed section ends with 0000h */
> +               while ((next[0] != 0 || next[1] != 0) && next + 1 < end)
> +                       next++;
> +
> +               next += 2;
> +               p = next;
> +       }
> +
> +       return NULL;
> +}
> +
> +static const struct efi_smbios_record *get_table_record(u8 type)
> +{
> +       const struct smbios_entry_point *ep;
> +
> +       ep = get_efi_config_table(SMBIOS_TABLE_GUID);
> +       if (!ep)
> +               return NULL;
> +
> +       if (!verify_ep_integrity(ep))
> +               return NULL;
> +
> +       return search_record((void *)(unsigned long)ep->st_address,
> +               ep->st_length, type);
> +}
> +
>  static bool apple_match_product_name(void)
>  {
>         static const char type1_product_matches[][15] = {
> @@ -240,7 +344,8 @@ static bool apple_match_product_name(void)
>         const struct efi_smbios_type1_record *record;
>         const u8 *product;
>
> -       record = (struct efi_smbios_type1_record *)efi_get_smbios_record(1);
> +       record = (struct efi_smbios_type1_record *)(efi_get_smbios_record(1) ?:
> +               get_table_record(1));
>         if (!record)
>                 return false;
>
> --
> 2.50.1
>

