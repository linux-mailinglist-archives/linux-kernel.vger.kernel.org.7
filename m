Return-Path: <linux-kernel+bounces-851612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89ABD6E46
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1CE3A78A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F181E8337;
	Tue, 14 Oct 2025 00:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo10iLRi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274C189F43
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402742; cv=none; b=GgQ7tVneYaCXD3qxSO8r8GcCguEZjkBsUF8uIHHecvz80Gt2CCmuIde8YUiQERiZrNQ6xFvvKOV0cwAfNX/mnu2tO++Lw/JwM8rzCu3Yj2lB0bEJ4UN/Qaqciyzp1G5bxDV3FlwYuliWwZJ35kyYaaYUU8tBQXJgQa+UBnAp4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402742; c=relaxed/simple;
	bh=JcZelsq/PIAsrgVSHUg+KLz83w1q+rCbK8RTu43rRyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j243Mm8MEva4VVS8+O1LLVjtVzXsi9kUerjsZl4zb8+ve21hToLQBvk1jALvKBepyLoazQ0AslZmOiWdY7YtRX0UtyucoTJAC1ZIiRAvZlyQ3BFB0ZaOYfqwuZ/BmNziAVHqmRPycscYjwHUS8GFqjHeprtzbN/KyBdf+pe3VXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo10iLRi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so5467353e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760402739; x=1761007539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUD/jVSiKW3v0sIyHa6sAxlrn0JeEDNdxvp/8zJeNbo=;
        b=Vo10iLRiMGzWmpHgh7VJrk2lAly3Bjgk1yCv9/MiEdB0R8kZKxja3KDtR+7wkQi+Lg
         BoB81HGAb+T3iMJcqL49Awpwilaqjp9A8jnn7nfF1CO3vJ//WoCbwpVTwin6u+sRlFI2
         lUadjvyW3/MMsqauOdA3lh/4KFeuE0XrWJrjUVyFu8g+SG+I15hlU/VNMa0efzYx+RcZ
         N/Hx5NUDnRBllr+FD18yyLbCLYBQ4f2F4eoQysbHXZT7AGA2VixInS+QQLarrjVr38rY
         jQmCECR7atZn/uHDjEnlbfFlXzeC3sU6Am9j6F+iwf/OldPgYcXF+qDDQK11XCMsALvI
         EpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760402739; x=1761007539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUD/jVSiKW3v0sIyHa6sAxlrn0JeEDNdxvp/8zJeNbo=;
        b=ZUyWMA4bJVnBAR8r0AnBzK4vGz2Fg8YR8+4FHsGgkIamJ10Ponwjm1u4cE+anSny3e
         FHqurmUoIo8xzSXAOC/7sQnXl6oaNbpFAeoEiqp5xMAPfXgsnKdeNzQjN0FXQvK+27UJ
         0vvpyeagFhxmkew9UUoBQgg1RO3+6/5DHcWTCMc0M4avBZOU0cGVpruED+0GJP1P/pFw
         /Dg+WNZXxP6sbqo3/KsmyJNJLGoNYTvl9Q6JyiEgkqYno+btW6yqQiSLsJCOh1Y42jG9
         Ubw89I3NkpWTPAeo3xQJjo8cRpzT+SyAWaOQ4WgUA3BzebHvWXJ1iEsMUpYVk6WFKFuE
         r9ug==
X-Gm-Message-State: AOJu0YxLr9WrKf3P0BP7bTGx25WoZtBXZ0yYaR1f2t2HEYXYgc0eB+xE
	0Nyg8m+ojMw52WyZmKQFusiJsG0nx21COnjXAHYRwVjv72B0SRzYXeahxKw9GSGNE6jAt5haiRD
	W/d3oZpYR2QNdG3ZEdZZHCLm/77A+hAq2DQ==
X-Gm-Gg: ASbGncsPLLX9koolfsEdjp7PDiDAyTgtxkiIAUeXMf7nCOfSgk20KCubn71KwKHLQOu
	dmfME+hYx3icb6d0Z9qPT7vHK4aedZCPE+n45gOyvZ/BUMuVGPjPBFHoLkLEAC4G7G2ubbOR7ZM
	8Q24T8zQG/jJUogcO2eZTWGIF8oBJFG+BMy7x5X+MOrGWDazWjRIp5ES53K9zDYRfQOj+3Zr8Lq
	bF4t65Hc44L8XM8VlezgdrgjwXeyjPNP1dzUWdK6We/zKnYaYy8ZycaezOwvwN3NNwR
X-Google-Smtp-Source: AGHT+IHZeSck4/1nzCrNXvRsOhHQpkFkFWgJItw3kXnz9Mh/AbQoIG6hTMmdhHT1T17W1QJZdcqcJkP6Yq/tNibSkyc=
X-Received: by 2002:a05:6512:31c2:b0:55f:4ab0:79a7 with SMTP id
 2adb3069b0e04-5906d75f8c2mr6663170e87.7.1760402738431; Mon, 13 Oct 2025
 17:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <87zfa016bd.fsf@osv.gnss.ru> <CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
 <87v7ko11iw.fsf@osv.gnss.ru> <CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
 <87plav2186.fsf@osv.gnss.ru> <CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
 <87y0piiz04.fsf@osv.gnss.ru> <CAOMZO5A2YMQQV8J6jg2o0C3qeFif0fSc5j6-98xhqNz=Lk4T+Q@mail.gmail.com>
 <87ecr9upfd.fsf@osv.gnss.ru>
In-Reply-To: <87ecr9upfd.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 13 Oct 2025 21:45:26 -0300
X-Gm-Features: AS18NWDJ_dAAFJxieANdnjwAuP56E0dOEh8us9C0h_IcTEAgsc8PkgJaZtTd8zA
Message-ID: <CAOMZO5DmzokFbmucbcDg73CKzaz0vVdMgnfLdBapHFLWVzEqpA@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Angelo Dureghello <angelo@kernel-space.org>
Content-Type: multipart/mixed; boundary="000000000000e2e105064113b35e"

--000000000000e2e105064113b35e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Sat, Oct 11, 2025 at 5:57=E2=80=AFPM Sergey Organov <sorganov@gmail.com>=
 wrote:

> I'm not familiar with the code and can't figure what exactly I'm
> expected to check. Could you please prepare a patch, and I'll be happy
> to apply and check it.

Here is a patch you can try.

It's not a formal patch yet, as it needs to be split.

--000000000000e2e105064113b35e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ARM-imx6sx-Initialize-RC-OSC-for-TO1.2-to-fix-low-po.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-imx6sx-Initialize-RC-OSC-for-TO1.2-to-fix-low-po.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mgpuawju0>
X-Attachment-Id: f_mgpuawju0

RnJvbSA3OWNhZjlkMmI3NDQ5MTI0NWE2ZmQyMWE4NjNlMDg1N2ZhOGJjMjM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+CkRh
dGU6IE1vbiwgMTMgT2N0IDIwMjUgMjE6MjI6MjUgLTAzMDAKU3ViamVjdDogW1BBVENIXSBBUk06
IGlteDZzeDogSW5pdGlhbGl6ZSBSQy1PU0MgZm9yIFRPMS4yKyB0byBmaXggbG93LXBvd2VyCiBp
ZGxlIGhhbmcKCmkuTVg2U1ggc2lsaWNvbiByZXZpc2lvbiBUTzEuMiBhbmQgbGF0ZXIgcG93ZXIg
b2ZmIHRoZSAyNCBNSHogWFRBTApkdXJpbmcgbG93LXBvd2VyIGlkbGUgYW5kIHN3aXRjaCB0byB0
aGUgaW50ZXJuYWwgUkMgb3NjaWxsYXRvci4KV2l0aG91dCBwcm9wZXIgUkMtT1NDIGluaXRpYWxp
emF0aW9uLCB0aGlzIHRyYW5zaXRpb24gY2FuIGhhbmcgZWFybHkKaW4gYm9vdCBvciByZXN1bWUg
ZnJvbSBpZGxlLgoKQm9hcmRzIGJhc2VkIG9uIFRPMS4wL1RPMS4xIGRvIG5vdCBleGhpYml0IHRo
aXMgYmVoYXZpb3Igc2luY2UgdGhlClhUQUwgcmVtYWlucyBwb3dlcmVkLCBzbyB0aGUgaW5pdGlh
bGl6YXRpb24gaXMgb25seSBuZWVkZWQgZm9yIFRPMS4yKy4KClRoaXMgY2hhbmdlIGNvbmRpdGlv
bmFsbHkgZW5hYmxlcyBhbmQgdHVuZXMgdGhlIFJDLU9TQyBiZWZvcmUgY3B1aWRsZQpzZXR1cCBm
b3IgVE8xLjIgYW5kIG5ld2VyIHNpbGljb24gcmV2aXNpb25zLgoKQmFzZWQgb24gdGhlIGZvbGxv
d2luZyBjb21taXQgZnJvbSB0aGUgTlhQIHZlbmRvciBrZXJuZWw6CgpodHRwczovL2dpdGh1Yi5j
b20vbnhwLWlteC9saW51eC1pbXgvY29tbWl0LzgxNjk3OGY4M2IxZDhkZDZjZTNiZDVkZDYyMjIz
ZGJmZGY3NGJkZDMKClJlcG9ydGVkLWJ5OiBTZXJnZXkgT3JnYW5vdiA8c29yZ2Fub3ZAZ21haWwu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+Ci0t
LQogYXJjaC9hcm0vbWFjaC1pbXgvY3B1aWRsZS1pbXg2c3guYyB8IDgwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQogZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2c3guYyAgICAgICB8ICAy
ICsKIDIgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWlteC9jcHVpZGxlLWlteDZzeC5jIGIvYXJjaC9hcm0v
bWFjaC1pbXgvY3B1aWRsZS1pbXg2c3guYwppbmRleCA4M2M1Y2JkMzc0OGUuLmU2OTRhMDFiODNk
NCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1pbXgvY3B1aWRsZS1pbXg2c3guYworKysgYi9h
cmNoL2FybS9tYWNoLWlteC9jcHVpZGxlLWlteDZzeC5jCkBAIC01LDcgKzUsMTAgQEAKIAogI2lu
Y2x1ZGUgPGxpbnV4L2NwdWlkbGUuaD4KICNpbmNsdWRlIDxsaW51eC9jcHVfcG0uaD4KKyNpbmNs
dWRlIDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUg
PGxpbnV4L29mLmg+CisjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPgogI2luY2x1ZGUgPGFz
bS9jYWNoZWZsdXNoLmg+CiAjaW5jbHVkZSA8YXNtL2NwdWlkbGUuaD4KICNpbmNsdWRlIDxhc20v
c3VzcGVuZC5oPgpAQCAtODcsOCArOTAsOCBAQCBzdGF0aWMgc3RydWN0IGNwdWlkbGVfZHJpdmVy
IGlteDZzeF9jcHVpZGxlX2RyaXZlciA9IHsKIAkJCSAqIGFuZCBzb21lIG1hcmdpbiBmb3IgU1cg
ZXhlY3V0aW9uLCBoZXJlIHNldCBpdAogCQkJICogdG8gMzAwdXMuCiAJCQkgKi8KLQkJCS5leGl0
X2xhdGVuY3kgPSAzMDAsCi0JCQkudGFyZ2V0X3Jlc2lkZW5jeSA9IDUwMCwKKwkJCS5leGl0X2xh
dGVuY3kgPSA4MDAsCisJCQkudGFyZ2V0X3Jlc2lkZW5jeSA9IDEwMDAsCiAJCQkuZmxhZ3MgPSBD
UFVJRExFX0ZMQUdfVElNRVJfU1RPUCB8CiAJCQkJIENQVUlETEVfRkxBR19SQ1VfSURMRSwKIAkJ
CS5lbnRlciA9IGlteDZzeF9lbnRlcl93YWl0LApAQCAtMTAwLDYgKzEwMyw3OCBAQCBzdGF0aWMg
c3RydWN0IGNwdWlkbGVfZHJpdmVyIGlteDZzeF9jcHVpZGxlX2RyaXZlciA9IHsKIAkuc2FmZV9z
dGF0ZV9pbmRleCA9IDAsCiB9OwogCisjZGVmaW5lIFBNVV9MT1dfUFdSX0NUUkwJCQkJMHgyNzAK
KyNkZWZpbmUgWFRBTE9TQzI0TV9DT05GSUcwCQkJCTB4MmEwCisjZGVmaW5lIFhUQUxPU0MyNE1f
Q09ORklHMQkJCQkweDJiMAorI2RlZmluZSBYVEFMT1NDMjRNX0NPTkZJRzIJCQkJMHgyYzAKKyNk
ZWZpbmUgWFRBTE9TQzI0TV9DT05GSUcwX1JDX1BST0dfQ1VSX1NISUZUCQkyNAorI2RlZmluZSBY
VEFMT1NDMjRNX0NPTkZJRzBfSFlTVF9NSU5VU19NQVNLCQkweGYKKyNkZWZpbmUgWFRBTE9TQzI0
TV9DT05GSUcwX0hZU1RfTUlOVVNfU0hJRlQJCTE2CisjZGVmaW5lIFhUQUxPU0MyNE1fQ09ORklH
MF9IWVNUX1BMVVNfTUFTSwkJMHhmCisjZGVmaW5lIFhUQUxPU0MyNE1fQ09ORklHMF9IWVNUX1BM
VVNfU0hJRlQJCTEyCisjZGVmaW5lIFhUQUxPU0MyNE1fQ09ORklHMF9SQ19QUk9HX1NISUZUCQk0
CisjZGVmaW5lIFhUQUxPU0MyNE1fQ09ORklHMF9FTkFCTEVfU0hJRlQJCQkxCisjZGVmaW5lIFhU
QUxPU0MyNE1fQ09ORklHMF9TVEFSVF9TSElGVAkJCTAKKyNkZWZpbmUgWFRBTE9TQzI0TV9DT05G
SUcxX0NPVU5UX1JDX0NVUl9TSElGVAkJMjAKKyNkZWZpbmUgWFRBTE9TQzI0TV9DT05GSUcxX0NP
VU5UX1JDX1RSR19TSElGVAkJMAorI2RlZmluZSBYVEFMT1NDMjRNX0NPTkZJRzJfQ09VTlRfMU1f
VFJHX01BU0sJCTB4ZmZmCisjZGVmaW5lIFhUQUxPU0MyNE1fQ09ORklHMl9DT1VOVF8xTV9UUkdf
U0hJRlQJCTAKKworc3RhdGljIHZvaWQgX19pbml0IGlteDZzeF9pbml0X3Jjb3NjKHZvaWQpCit7
CisJdm9pZCBfX2lvbWVtICphbmF0b3BfYmFzZTsKKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOwor
CXUzMiB2YWw7CisKKwlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJm
c2wsaW14NnEtYW5hdG9wIik7CisJYW5hdG9wX2Jhc2UgPSBvZl9pb21hcChucCwgMCk7CisJV0FS
Tl9PTighYW5hdG9wX2Jhc2UpOworCisJaWYgKGlteF9nZXRfc29jX3JldmlzaW9uKCkgPCBJTVhf
Q0hJUF9SRVZJU0lPTl8xXzIpCisJCXJldHVybjsgLyogTm90IG5lZWRlZCBmb3IgVE8xLjAvVE8x
LjEgKi8KKworCXByX2luZm8oImkuTVg2U1g6IEVuYWJsaW5nIGFuZCB0dW5pbmcgUkMtT1NDIGZv
ciBUTzEuMitcbiIpOworCisJLyogRW5hYmxlIFJDLU9TQyBwb3dlciAqLworCXZhbCA9IHJlYWRs
X3JlbGF4ZWQoYW5hdG9wX2Jhc2UgKyBQTVVfTE9XX1BXUl9DVFJMKTsKKwl2YWwgfD0gMHgxOwor
CXdyaXRlbF9yZWxheGVkKHZhbCwgYW5hdG9wX2Jhc2UgKyBQTVVfTE9XX1BXUl9DVFJMKTsKKwor
CS8qIENvbmZpZ3VyZSBSQy1PU0MgZnJlcXVlbmN5IHR1bmluZyAqLworCXdyaXRlbF9yZWxheGVk
KDB4NCA8PCBYVEFMT1NDMjRNX0NPTkZJRzBfUkNfUFJPR19DVVJfU0hJRlQgfAorCQkgICAgICAg
MHhhNyA8PCBYVEFMT1NDMjRNX0NPTkZJRzBfUkNfUFJPR19TSElGVCB8CisJCSAgICAgICAweDEg
PDwgWFRBTE9TQzI0TV9DT05GSUcwX0VOQUJMRV9TSElGVCB8CisJCSAgICAgICAweDEgPDwgWFRB
TE9TQzI0TV9DT05GSUcwX1NUQVJUX1NISUZULAorCQkgICAgICAgYW5hdG9wX2Jhc2UgKyBYVEFM
T1NDMjRNX0NPTkZJRzApOworCisJLyogY291bnRfcmNfY3VyID0gMHg0MCwgY291bnRfcmNfdHJn
ID0gMHgyZGMgKi8KKwl3cml0ZWxfcmVsYXhlZCgweDQwIDw8IFhUQUxPU0MyNE1fQ09ORklHMV9D
T1VOVF9SQ19DVVJfU0hJRlQgfAorCQkgICAgICAgMHgyZGMgPDwgWFRBTE9TQzI0TV9DT05GSUcx
X0NPVU5UX1JDX1RSR19TSElGVCwKKwkJICAgICAgIGFuYXRvcF9iYXNlICsgWFRBTE9TQzI0TV9D
T05GSUcxKTsKKworCS8qIHdhaXQgNG1zIGZvciBSQy1PU0MgdG8gc3RhYmlsaXplICovCisJbXNs
ZWVwKDQpOworCisJLyogQWRkIGh5c3RlcmVzaXM6IGh5c3RfcGx1cz0zLCBoeXN0X21pbnVzPTMg
Ki8KKwl2YWwgPSByZWFkbF9yZWxheGVkKGFuYXRvcF9iYXNlICsgWFRBTE9TQzI0TV9DT05GSUcw
KTsKKwl2YWwgJj0gfigoWFRBTE9TQzI0TV9DT05GSUcwX0hZU1RfTUlOVVNfTUFTSyA8PCBYVEFM
T1NDMjRNX0NPTkZJRzBfSFlTVF9NSU5VU19TSElGVCkgfAorCQkoWFRBTE9TQzI0TV9DT05GSUcw
X0hZU1RfUExVU19NQVNLIDw8CisJCVhUQUxPU0MyNE1fQ09ORklHMF9IWVNUX1BMVVNfU0hJRlQp
KTsKKwl2YWwgfD0gKDB4MyA8PCBYVEFMT1NDMjRNX0NPTkZJRzBfSFlTVF9NSU5VU19TSElGVCkg
fAorCSAgICAgICAoMHgzIDw8IFhUQUxPU0MyNE1fQ09ORklHMF9IWVNUX1BMVVNfU0hJRlQpOwor
CXdyaXRlbF9yZWxheGVkKHZhbCwgYW5hdG9wX2Jhc2UgICsgWFRBTE9TQzI0TV9DT05GSUcwKTsK
KworCS8qIFNldCBjb3VudF8xbV90cmcgPSAweDJkNyAqLworCXZhbCA9IHJlYWRsX3JlbGF4ZWQo
YW5hdG9wX2Jhc2UgICsgWFRBTE9TQzI0TV9DT05GSUcyKTsKKwl2YWwgJj0gfihYVEFMT1NDMjRN
X0NPTkZJRzJfQ09VTlRfMU1fVFJHX01BU0sgPDwgWFRBTE9TQzI0TV9DT05GSUcyX0NPVU5UXzFN
X1RSR19TSElGVCk7CisJdmFsIHw9IDB4MmQ3IDw8IFhUQUxPU0MyNE1fQ09ORklHMl9DT1VOVF8x
TV9UUkdfU0hJRlQ7CisJd3JpdGVsX3JlbGF4ZWQodmFsLCBhbmF0b3BfYmFzZSAgKyBYVEFMT1ND
MjRNX0NPTkZJRzIpOworCisJLyogSGFyZHdhcmUgcmVxdWlyZXMgd3JpdGluZyBDT05GSUcxIGFm
dGVyIHJlYWRpbmcgaXQgKi8KKwl2YWwgPSByZWFkbF9yZWxheGVkKGFuYXRvcF9iYXNlICsgWFRB
TE9TQzI0TV9DT05GSUcxKTsKKwl3cml0ZWxfcmVsYXhlZCh2YWwsIGFuYXRvcF9iYXNlICsgWFRB
TE9TQzI0TV9DT05GSUcxKTsKK30KKwogaW50IF9faW5pdCBpbXg2c3hfY3B1aWRsZV9pbml0KHZv
aWQpCiB7CiAJaW14Nl9zZXRfaW50X21lbV9jbGtfbHBtKHRydWUpOwpAQCAtMTEzLDYgKzE4OCw3
IEBAIGludCBfX2luaXQgaW14NnN4X2NwdWlkbGVfaW5pdCh2b2lkKQogCSAqLwogCWlteF9ncGNf
c2V0X2FybV9wb3dlcl91cF90aW1pbmcoY3B1X2lzX2lteDZzeCgpID8gMHhmIDogMHgyLCAxKTsK
IAlpbXhfZ3BjX3NldF9hcm1fcG93ZXJfZG93bl90aW1pbmcoMSwgMSk7CisJaW14NnN4X2luaXRf
cmNvc2MoKTsKIAogCXJldHVybiBjcHVpZGxlX3JlZ2lzdGVyKCZpbXg2c3hfY3B1aWRsZV9kcml2
ZXIsIE5VTEwpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg2c3guYyBi
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnN4LmMKaW5kZXggNjlmOGY2ZjljYTQ5Li5mZjliY2Jm
MzAxNTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14NnN4LmMKKysrIGIvZHJp
dmVycy9jbGsvaW14L2Nsay1pbXg2c3guYwpAQCAtNTEwLDYgKzUxMCw4IEBAIHN0YXRpYyB2b2lk
IF9faW5pdCBpbXg2c3hfY2xvY2tzX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpjY21fbm9kZSkK
IAkJCSAgICAgICBod3NbSU1YNlNYX0NMS19MQ0RJRjFfUE9ERl0tPmNsayk7CiAJfQogCisJY2xr
X3NldF9wYXJlbnQoaHdzW0lNWDZTWF9DTEtfUEVSQ0xLX1NFTF0tPmNsaywgaHdzW0lNWDZTWF9D
TEtfT1NDXS0+Y2xrKTsKKwogCS8qIFNldCB0aGUgcGFyZW50IGNsa3Mgb2YgUENJZSBsdmRzMSBh
bmQgcGNpZV9heGkgdG8gYmUgcGNpZSByZWYsIGF4aSAqLwogCWlmIChjbGtfc2V0X3BhcmVudCho
d3NbSU1YNlNYX0NMS19MVkRTMV9TRUxdLT5jbGssIGh3c1tJTVg2U1hfQ0xLX1BDSUVfUkVGXzEy
NU1dLT5jbGspKQogCQlwcl9lcnIoIkZhaWxlZCB0byBzZXQgcGNpZSBidXMgcGFyZW50IGNsay5c
biIpOwotLSAKMi4zNC4xCgo=
--000000000000e2e105064113b35e--

