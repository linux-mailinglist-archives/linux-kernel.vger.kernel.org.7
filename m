Return-Path: <linux-kernel+bounces-764543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F3B2244F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDFC2A5118
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395042EBB9A;
	Tue, 12 Aug 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOUM1Wzw"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B302EAD19;
	Tue, 12 Aug 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993396; cv=none; b=rrRNTlbX5y5rq5A+osWx8N1fiisyFoiDrxCa+f290/Qeo+j9YYZ+SBsn2SdZDij4Zea17jbLMBC5Sa3TEJmTLhhxNCAOaZebdAuCuQ1iDxBXnZlot3Hx4APZzW+nrutnoAs+l8y1h6UTbSpBLhnrVtsjzoRZigCAvJdlx6VSHrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993396; c=relaxed/simple;
	bh=6P/aKqG7fY1LNdU4jwyXEd4Urbpceh+qKNGedxVIFJc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XbFHfZiBagE6/XAY9mv3kcDBoyNkUqnXFXKxnfxUz9lPG/7d8kUDrmlhnK3SzCbpmcSF0EX0tf3HexfmBdZZMZ0HOdgwyoF6uIgxamwL0PKJjHXJbV5bOtUScDmENmu5brZD+wh+Pt+zDlRLSQGrbnKM8CG+0rN00xicsj49+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOUM1Wzw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bc5e68d96so4566736b3a.3;
        Tue, 12 Aug 2025 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754993394; x=1755598194; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P/aKqG7fY1LNdU4jwyXEd4Urbpceh+qKNGedxVIFJc=;
        b=BOUM1Wzwb6fLx8iuBsYFYMm2Vl0+JrS8nGphlgcw6WiZ8P+jv1hVDI+ts0LZbFjsFJ
         IxZz1qek8jvtSSRA0+ARsBiqNbjJ6Yq4XblLk0QkPT3ODmMpqOkuacJwhjbGNTp8+rps
         vb7xsWoCctWK3VttHKFEr51WrRKGR+fnHZ2+oPPE4HpBHP3D53+47Wu01cb8A4tCOQ4c
         5oIy58R/LRC4r+Kmyx9wSJlrWk+stGWAAIzqI2v818Xj0aZCJNOv1khAhiObpnNIFwqW
         a5ek3TOh2iMMEAiDezkEvyO5H6v9jS0vqo0PdQm5bYusbhQvFF7E0r5hRr9sZ3iU5fJX
         Bzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993394; x=1755598194;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P/aKqG7fY1LNdU4jwyXEd4Urbpceh+qKNGedxVIFJc=;
        b=BUO1OPrP0fiMg/dx1ppSVsFfQLtbiJL7nZ0WtG8AejlbIvVoD/qwF2jTB5+f1xtQXu
         TqG/yMiy1kpJ9s3lQ+lL0E371xRLDqU+1SW9MFPfKaM4bYnJODHSv4CfXHD/ysJpeZpi
         H8e2HQ2Jz91oAcGc67354smYCv+OuMzc2Mn/8T++RollWfhFDPgafjjaX1ahzG3VvB4e
         UhBm+oUxHW/QC06y3BmTPzT7kcXGE2pIdep0Rvf/IocCZQyuX07tNK1wQcJoXVSWF/80
         lFC2535b55DXiIkOs3v6PvFoBpjL9VZ5gbZ0uW/GiWVciSoSO7ZgWdBGpXBjxZ+oO8JV
         HM7w==
X-Forwarded-Encrypted: i=1; AJvYcCUCEv6rZ6M5tqTOEeS/ORUaEUCyCO502m3pY4jOarEC1L2fJ1E6bHkXRGWBiTlK3MwqZ6OZaUaOekaoANqx@vger.kernel.org, AJvYcCWF9yPuRMVeEtxSelhvc6Ar7fyCNsyV0pFSdO76A1aPc4OYWgiUILIoo0k5lNEsvXXQOUQBo6haiMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8ydNMyXGGtIIQSSNacyHBwgEqgifrRUGFkPoD+HiK/Rb1pVR
	u1GHZLgfEFuLwd4nJDgCo93bN0PA5uIEOSqD7GHQiFYcXjp5o4U2IarU
X-Gm-Gg: ASbGnct4nZ5mY0N3gxmTVKesGjHdn1zh8xtLW3HTl0FHuKc0xBUMT/1WdORVx3gewkC
	0VhSpcvZ+keDk1EeoFC+3WLXg6TIV4RJj9wC8t3Pr2n0fQUuV6jYIlhmUdYzxc4r23WGLGvtp0f
	isE3XoIHkLuvArhyeNPTp+EnzPibvPBn4jeU2NKqxLUqi35tX1e4eczFZx2WXQcp+UPI8qfo/t2
	ay/nMRjDvagk2hareK7BmX7p2bVxG8GT0tCZBIrWGq9H5KDHqhBg9OdFv5+KqUct8BbwzSbz1tH
	Ds8LVHpiydS6txb8jVOLIs64DHB1vNiu2HCLoTixQQJGsUSrLh8N1xMl0INVMoqIz6wBVslT0z4
	LDA2/XYKqrlwgIpNxPmJ97EWwAfskNn7m7Jey6SkpshPR2AVKai3fn1yu//Y=
X-Google-Smtp-Source: AGHT+IE2nqLcR9tuo96ZhS1ZUKd54JX6A+KTh4EPFXhV5gCmV6hy1i4mQwGOVd2xlqr8XgG5zWKYCQ==
X-Received: by 2002:a05:6a20:3d1c:b0:23f:f88a:c17d with SMTP id adf61e73a8af0-2409aa01f0amr4242244637.42.1754993394153;
        Tue, 12 Aug 2025 03:09:54 -0700 (PDT)
Received: from smtpclient.apple (wf122-104.ust.hk. [175.159.122.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf772116asm23029958b3a.97.2025.08.12.03.09.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:09:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH V2] scripts/checktransupdate.py: add support for scanning
 directory
From: Haoyang LIU <tttturtleruss@gmail.com>
In-Reply-To: <20250811212446.GA924610@ax162>
Date: Tue, 12 Aug 2025 18:09:38 +0800
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
 Yanteng Si <si.yanteng@linux.dev>,
 Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 hust-os-kernel-patches@googlegroups.com,
 linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <31217D41-748F-4528-B3C0-60CC5EB6833F@gmail.com>
References: <20250811170050.94997-1-tttturtleruss@gmail.com>
 <20250811212446.GA924610@ax162>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)



> On 12 Aug 2025, at 05:24, Nathan Chancellor <nathan@kernel.org> wrote:
>=20
> Hi Haoyang,
>=20
> On Tue, Aug 12, 2025 at 01:00:50AM +0800, Haoyang LIU wrote:
>> Origin script can only accept a file as parameter, this commit =
enables
>> it to scan a directory.
>>=20
>> Usage example:
>> ./scripts/checktransupdate.py =
Documentation/translations/zh_CN/dev-tools
>>=20
>> Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
>> ---
>>=20
>> V1 -> V2: remove the fix of missing "f" in f-string and make it a new =
patch
>>=20
>> scripts/checktransupdate.py | 24 ++++++++++++++++++++++++
>> 1 file changed, 24 insertions(+)
>=20
> Thanks for the update. While this seems reasonable to me from a purely
> surface level glance over the actual Python, I have added the
> Documentation folks that Dongliang added from the previous thread, who
> really own and maintain this file (the original patch is at [1]). =
Please
> include them in future revisions should they be necessary. It would
> probably be good for something like this to be applied?
Hi Nathan
That makes sense. My V1 patch also missed Dongliang Mu and the other =
maintainers. Thanks for pointing it out.

Sincerely,
Haoyang
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..b7e3a8c8832e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,6 +7302,7 @@ P: =
Documentation/doc-guide/maintainer-profile.rst
> T: git git://git.lwn.net/linux.git docs-next
> F: Documentation/
> F: scripts/check-variable-fonts.sh
> +F: scripts/checktransupdate.py
> F: scripts/documentation-file-ref-check
> F: scripts/get_abi.py
> F: scripts/kernel-doc*
>=20
> [1]: =
https://lore.kernel.org/20250811170050.94997-1-tttturtleruss@gmail.com/
>=20
> Cheers,
> Nathan


