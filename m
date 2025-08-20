Return-Path: <linux-kernel+bounces-776946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 304DCB2D354
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB47B700B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969532517AF;
	Wed, 20 Aug 2025 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6XObd1/"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D6283689
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667091; cv=none; b=otnboa6SldTC1sILWwGjT7xX0bBJQcDMvco5vr3E0AlMtukV+eRrKGGESinnzvsrnw03tTH7J3bm7B+VMn38Xb9WDWHC4Hec3CMYfypN/oGtzmCs2/LRl/ar7wXliDEnr1VxKgrCkv0wfwc1EAOhfWrZ/qnnhhNvCEqX34fzFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667091; c=relaxed/simple;
	bh=2NuIlexl8sKdTpa8K3Ng1YH290AAfgSN9p/5/nsGJ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGA/VgJkJWrfpu2sXHuJIHq+aX57At5QmHjX9C6AIzWL3Zc1Uy2ldg4W/OxVQ3WzoaZev0bW0nFCORWC8GT+EXcQ8QY0uhga8STjRTWDOGMGJ+viyWofdeRhZjO8nca5D8TFiF1jxP2PUNZ/sUUylm7VYtaXxpG/NO/XyYdWVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6XObd1/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3234f8df749so519916a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755667088; x=1756271888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NuIlexl8sKdTpa8K3Ng1YH290AAfgSN9p/5/nsGJ6c=;
        b=a6XObd1/AMvjySTFwPTrOugMfXcfgsl6xp9ZIkQr4q0iCvMntOsr7wZK3fF5JVSlyR
         KJhdwWQRRfOz8Nn1rrEnHbsd4ETWB4gPWg53TaG9N9PxYgNyVrB4VKkHa99MYQ/mTupk
         gbWgFLZI3ygV2idmljfT2K4kXaH67Wj94xPM2HeEYRimctOH7Q/W7zu9vqtw84+InlwP
         yl0+t+WWHbkLS7Gmk0fli9PQJ60w3vlyf5tJhyTBUy9HOQGJwBQ6psx06TW09mqw3FJy
         tOhwzomm1Ia4d+uRn+9hx0/ubmnuOLP4fecL3iTtr/lYPQXfhObJ7IGjXu0wDjnXldjZ
         X3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755667088; x=1756271888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NuIlexl8sKdTpa8K3Ng1YH290AAfgSN9p/5/nsGJ6c=;
        b=u+K7IKoEkTMp5qWoI9Xw1nyeUz1pwRociwdBKTVxgr4ax6yN6NLvpt8jdbzk605Nkv
         YG0PIGaifPXItqF19CwgB5fhzEpDz//FDIuPPbngk1XFK8g2YvVMNM/ZRd9nkhNS5A4D
         RU7yhczDSPEG4C20H1c3ibADbzyKqtSoJ9MaeIL0hGWPaqSZcNm8Vqwzv2OoWbrvTVFy
         4qqwcukonEuFZqMnStINfKfGgg4aI7EIZsEak2MoxOit5e1f70cwl8VsZv0obk2qQ8f8
         ANxZNgQrzOkwBeSdXLay62n+vD0E7r6icplH9+XahCZSpE7rbHGgqSW1v6vvWhpBXmUN
         mbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuxHIgqqQhgu+dhmy9d09qPaDsJyLyuJdikYlcexR4QpTwN4JBVLIsts5B99nYzQGkGbr3GY41PhrQzMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCeMGmKgH1aeIKCvlxbJHfPQI73gexa0j4d0uWYaWBOgTY7Eq
	rZvsZHZjTI6ACxum8hNKSJGxYbiun5Fjx9vgjXhiVPkWzb19cC4f+tHA
X-Gm-Gg: ASbGnctULU5g/bwGzpB1nW2Dlhad+2zO1K8ISdDCPOuFEy43JDkfuDQKtmGcMMlXlCw
	LVhzF+/4TJxW03UYao487hJicvN1QHqCv4BNzSzVJqAIu2EAvfontynlLV6aBnU8WowdvZAZTG/
	IYmYcCZ7DytOynDO+dVUly4EX2/4de04tGXYkJ0QLcqbdz5SZq6C3LtaYK3IcMHkkMBJbZnYHbM
	qdx9oI5RV7u2KldZB3i206hhX95DW9LuoHYf+MdJgJ+K/eoebvQxqYz2IeirUPi3hn6AJAkP6om
	kcA9JGxcauexoTlWmr2EScRSUupoeRsBkPyoQYTAYcjXnSXeq/KfvtL+gt7WrVZlzjYQrPAc7uV
	n9u1ISti/LGlYoXbprvHpRfpYuIwitkA=
X-Google-Smtp-Source: AGHT+IHMD1LcX/pupFGgRrDlklcZoViMXprsqGd+UJfEK6hegF2tXkrCHXzy/74dHLRMWkAbHXwraQ==
X-Received: by 2002:a17:90b:1b04:b0:31e:f30f:6d21 with SMTP id 98e67ed59e1d1-324e1178c04mr1315233a91.0.1755667087796;
        Tue, 19 Aug 2025 22:18:07 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e250eba9sm1003418a91.2.2025.08.19.22.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 22:18:06 -0700 (PDT)
Date: Tue, 19 Aug 2025 19:18:01 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Nai-Chen Cheng <bleach1827@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] drm/display: remove dead code in
 drm_edp_backlight_probe_state
Message-ID: <aKVaiRpULAGceEMD@hobbes>
References: <20250820-drm-dp-helper-logically-dead-code-2-v1-1-34421f4a7442@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fxN+yevHhckMWmys"
Content-Disposition: inline
In-Reply-To: <20250820-drm-dp-helper-logically-dead-code-2-v1-1-34421f4a7442@gmail.com>


--fxN+yevHhckMWmys
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:30:31AM +0800, Nai-Chen Cheng wrote:
> In the error path where ret < 0, the ternary operator "ret < 0 ? ret :
> -EIO" will always evaluate to ret since ret is guaranteed to be
> negative. Simplify by directly returning ret.
>=20
> Found by Coverity(CID 1649044).

Acked-by: Joey Pabalinas <joeypabalinas@gmail.com>

--=20
Cheers,
Joey Pabalinas

--fxN+yevHhckMWmys
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmilWokACgkQqoHu9CTx
owLvWA/+OO8g6BVZk+PAWFYiWYD3imnpadaeoeKx42wPLV0y7LZrR9uZ1G+dCZyU
BCmDPq8FI+RPvV4mocggajuHvaU/ZtISUJ2C7gbIK6mJtl8SpyNe+DWPnOdo6euI
D2Y++3ds9im824TWlMTZUo9OkycrQCXYG3s1d3xftQjcqqmw/oZ96K4SAAyRQP7w
VnUQAhh562U6gN1rlCrwZSuyHykCoFyqSkZ83VcLt7RpDL+3oP4gagPN/vhiFcBt
+7qPYRsPBJZmketrhMOb/iS1a4IEESGzeezF3yZ5FpCcpVpLS3Ajw0+n/aLreGc5
/eJIolvhHGVenIjA0Xi3WgoyP9h9Zyj8fOJshhbtQ19nRBMe3ZSxn64PPNGHxbUN
L6jCmuDFMsCJS/Jqx6x1IfHbs/Ont3orkTwR1SJTRzt120NVN65RbfQMeU4MhZQY
4C+3DVi7BULnAduseq66qz5U/qA7r9s//8YpLDn8PW7UC5cjQHd2JcWmeSeDLJUe
LqCOB8jAFy+AO9rCpBrrhtE26dUeAA/Dl2XbOuns/87Oo5GKBamuDY2MCwhJbaw0
Z308BOM0TdtmOzsO7C4tYqQoG0/fpa7vXUXSrChCcq7NLoK+a9JrUmlXG2wwhjzI
f57T2lvKSVXMdPmBSgg64rfNAmpkT+AUN9BQxSCQSkWUAKnbARY=
=K/q7
-----END PGP SIGNATURE-----

--fxN+yevHhckMWmys--

