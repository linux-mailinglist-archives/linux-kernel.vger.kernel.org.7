Return-Path: <linux-kernel+bounces-867114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B310C01A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664E6566D16
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CCF338F3D;
	Thu, 23 Oct 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vee6yxj/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80778328B4F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227649; cv=none; b=owAlWVeb6unv9dSRqeSHZw+2PUMYKFT3VKQ+D7UAcKCXtWFrKgRKuiMs5ySHEvgGTJTxJuU0Hc5TuGfIb5gq0RmOLKhHJccdtxKRZ3W8HSKggmDGmAm43WH9aIuH8Z6Rra8YFpszLk+zUTNMICKDNrWXHRV0SLHp/wvHMdKk5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227649; c=relaxed/simple;
	bh=RfPxMSw2QIXAl1hUeAj4vLMRl8SraU4Rx5q/wyYKIsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6t2CPiQAkirN5y0ddQTReSDefmvPGt4gS0PHzBCrfykTmN/CKFpiGBaEgmUAcMNkKkhyignrmVw+5W5NsOUeRuKlVNl3K6xMTOLy8tMQRQGyoNFKdS2qCiBG/TbZ4MbOLqMnVljpO7dRGQS+hFb++e0Bvi1FRvn7mLw6n1U2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vee6yxj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B9AC16AAE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227649;
	bh=RfPxMSw2QIXAl1hUeAj4vLMRl8SraU4Rx5q/wyYKIsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vee6yxj/24ueBSgmHygLFhnx5T9QP+vM/0Wk5ucC8ZyirgSts/om7GjyozWs2ksyL
	 8p7dsgC+WsqN69VS77JMzwMImwnQWo3Vi4tzDwy6EXFYlQKKndlKWPc7vwyUQ88xvt
	 dF99URPHNLfy25kfsaWqbLNf/8RbubLWMsqxDeR+4l5qcn1IQPr9FuKnnEvyZKr6XQ
	 PqP10qqujRs4CpmxRes+s4KBpBKSaPY/poaJoMyWJ1MKEhmHojNwoOSe7jl0DuwFKQ
	 ZVerh1YKw6K1UlEhYT4R/lBG3LcgvdnysVRxZh55xmrJ0RyHlot6uwd5ucjlXlAjdU
	 3nCpGvDDMUmNQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so1068752e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:54:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnZQpqjNFRbV3JBUiLieGvWpzgM9kTtiU2nnLKgafSxrfVDRCe+T1hJeuJI2OXlR6I711HUc1fqibF4DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpcJ1BBO3v16I0UidFCckDCIXtpc/k++Tdz5BrFHLoCFLX0BKl
	Yd+HsVixnxUByXrK9CAPkhGzvUIo2d2m5yzVtQYJVPeZ3BWG3CcEwJuUFcDXzxSlGyyO/IHWuMe
	upReTUvFr7n9+C0wM2eDFKCZjTuH5les=
X-Google-Smtp-Source: AGHT+IH63I3YDCWvXw19hOEkn74E8hdzU8BAlboVTMje/88UlQ/muTuUzsMjCY/XKm2lKHroXy/SghLWJPM42JYYza4=
X-Received: by 2002:a05:6512:3c94:b0:591:c2f8:9a60 with SMTP id
 2adb3069b0e04-591d855a76dmr9322835e87.31.1761227647656; Thu, 23 Oct 2025
 06:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com> <20251022201953.GA206947-robh@kernel.org>
 <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
 <CAMj1kXGYinTKiyYhNYWJvoJeUJScCGnyq=ozLgjKAm7_wzG8QA@mail.gmail.com> <CAERbo5waY-=6BLZ2SiJSFAXzvU57mJdM9q05vAZw8zR2yExQ5w@mail.gmail.com>
In-Reply-To: <CAERbo5waY-=6BLZ2SiJSFAXzvU57mJdM9q05vAZw8zR2yExQ5w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 23 Oct 2025 15:53:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHin5YacS98ttzHqFqy6HMukXKoLZtr-+bLwVRsWZUugQ@mail.gmail.com>
X-Gm-Features: AS18NWBSb1VJmPrx9Cc72lYaWC9k8c3VPjSe9O5-Bd_WfBtnDzMwtR_vVl21jXA
Message-ID: <CAMj1kXHin5YacS98ttzHqFqy6HMukXKoLZtr-+bLwVRsWZUugQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Adriana Nicolae <adriana@arista.com>
Cc: Rob Herring <robh@kernel.org>, krzk@kernel.org, jdelvare@suse.com, 
	frowand.list@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, vasilykh@arista.com, arm.ebbr-discuss@arm.com, 
	boot-architecture@lists.linaro.org, linux-efi@vger.kernel.org, 
	uefi-discuss@lists.uefi.org, linux-arm-kernel@lists.infradead.org, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc Ilias)

On Thu, 23 Oct 2025 at 15:34, Adriana Nicolae <adriana@arista.com> wrote:
>
> On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > On Thu, 23 Oct 2025 at 04:21, Adriana Nicolae <adriana@arista.com> wrot=
e:
> > >
> > > On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@kernel.org=
> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > > > > Some bootloaders like U-boot, particularly for the ARM architectu=
re,
> > > > > provide SMBIOS/DMI tables at a specific memory address. However, =
these
> > > > > systems often do not boot using a full UEFI environment, which me=
ans the
> > > > > kernel's standard EFI DMI scanner cannot find these tables.
> > > >
> > > > I thought u-boot is a pretty complete UEFI implementation now. If
> > > > there's standard way for UEFI to provide this, then that's what we
> > > > should be using. I know supporting this has been discussed in conte=
xt of
> > > > EBBR spec, but no one involved in that has been CC'ed here.
> > >
> > > Regarding the use of UEFI, the non UEFI boot is used on Broadcom iPro=
c which
> > > boots initially into a Hardware Security Module which validates U-boo=
t and then
> > > loads it. This specific path does not utilize U-Boot's UEFI
> > > implementation or the
> > > standard UEFI boot services to pass tables like SMBIOS.
> > >
> >
> > What prevents this HSM validated copy of u-boot from loading the kernel=
 via EFI?
> The vendor's U-Boot configuration for this specific secure boot path
> (involving the
> HSM) explicitly disables the CMD_BOOTEFI option due to security
> mitigations, only
> a subset of U-boot commands are whitelisted. We could patch the U-boot
> to include
> that but it is preferable to follow the vendor's recommandations and
> just patch U-boot
> to fill that memory location with SMBIOS address or directly with the
> entry point.

And what security mitigations are deemed needed for the EFI code? You
are aware that avoiding EFI boot means that the booting kernel keeps
all memory protections disabled for longer than it would otherwise. Is
this allowlisting based on simply minimizing the code footprint?

Introducing a non-standard mechanism means that others will now have
to maintain it and coexist with it, rather than simply using the
existing code which already fully supports what you are trying to
accomplish (both on the bootloader and the kernel side)

IOW, in my opinion, simply enabling CMD_BOOTEFI for your bootloader is
a much better choice here. I'm not a u-boot expert but as I understand
it, loading/authenticating the image and booting it in EFI mode are
two separate things, and so the secure boot path would change very
little.

> > > Because there's no UEFI configuration table available in this boot mo=
de, we need
> > > an alternative mechanism to pass the SMBIOS table address to the kern=
el. The
> > > /chosen node seemed like the most straightforward way for the bootloa=
der to
> > > communicate this non-discoverable information.
> > >
> > > I wasn't aware of the EBBR discussions covering this. I've added the
> > > boot-architecture and arm.ebbr-discuss lists to the Cc. If there's a =
preferred
> > > EBBR-compliant way to handle this for non-UEFI boots, I'm happy to ad=
apt
> > > the approach.
> > >
> >
> > For the record, I don't see a huge problem with accepting SMBIOS
> > tables in this manner, but it would be better if a description of this
> > method was contributed to the DMTF spec, which currently states that
> > the only way to discover SMBIOS tables on non-x86 systems is via the
> > SMBIOS/SMBIOS3 EFI configuration tables. Doing so should prevent other
> > folks from inventing their own methods for their own vertically
> > integrated systems. (Other OSes exist, and from a boot arch PoV, we
> > try to avoid these Linux-only shortcuts)
> >
> > However, the DT method should *only* be used when not booting via
> > UEFI, to avoid future surprises, and to ensure that existing OSes
> > (including older Linux) can always find the SMBIOS tables when booting
> > via UEFI.
> >
> > Also, I would suggest to pull the entire entrypoint into DT, rather
> > than the address in memory of either/both entrypoint(s). Both just
> > carry some version fields, and the address of the actual SMBIOS data
> > in memory, and the only difference between SMBIOS and SMBIOS3 is the
> > size of the address field (32 vs 64 bits)
> I understand the points raised about UEFI taking precedence and the
> preference for standardization (DMTF). If this DT method is accepted
> as a fallback only for non-UEFI boots like this one, the kernel implement=
ation
> will respect that precedence.
>
> Regarding the alternative to place the full SMBIOS entry point structure =
into
> a DT property (as a byte array) instead of just its memory address. Both
> approaches seem feasible from the U-Boot side. I opted initially for pass=
ing
> the address to reuse the existing kernel functions (dmi_smbios3_present a=
nd
> dmi_present) which already handle mapping and validation of the entry poi=
nt
> read from memory (as done for the EFI case).
>

Actually, it appears that dmidecode expects the entrypoint data in
/sys/firmware/dmi/tables/smbios_entry_point, and so you will need to
populate that file in any case, and so pulling it into the DT node is
not as useful. But having both SMBIOS and SMBIOS3 is pointless, so
please only bother with the latter.

