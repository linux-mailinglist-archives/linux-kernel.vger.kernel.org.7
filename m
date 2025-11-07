Return-Path: <linux-kernel+bounces-890959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 549FDC4175B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 085824E3E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53880334690;
	Fri,  7 Nov 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip6BYIc0"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2353191D4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544712; cv=none; b=YSjrHaCmdHEdzDlmAazVrcouGrzRaIxR+YaCBJLI2wdPo8X2FbHDrm915AYrhOgqhY5oUmsCHTOImjSX4YA/zSZDV+EDBwyxtRzT/zfwEhdBecgWtVoiozckdd8tEb5Iw44Oc/dm6hdsTECNSRVOGnJTfkRIxALGWEJ39GgBf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544712; c=relaxed/simple;
	bh=LJd4Lt7kd+i0Y3qfV8wxl3MYHl5ygopfsMQ71Ksl2t0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tf4XwVfm2m2/hpNvebgjkBaRA27KPGu8y2h5jsD01Tx300Eg8rQAsdHSKnQQpzJh/+uJGs/sAcM9Gc+wgjxjuImEyd4TvWxGmGwGdCXRYIlsiAyTPElTeGREJI31Z0U2vc/P93f3SsL/ieDwKMYzbnJGn/UafiLIKqDGrvb3hEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip6BYIc0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so1338162b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762544709; x=1763149509; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJd4Lt7kd+i0Y3qfV8wxl3MYHl5ygopfsMQ71Ksl2t0=;
        b=Ip6BYIc0KsSJYUifZxNC4bhLYAGJOrP5+vzkMuEu0kid06sRgJEkqxRqQ8XeKS23/7
         sVjJKTWGT0WO1zDLDLpAek15uL11UU+lFhzn65CWngkeRwRgT2rYdvaLjtQCeMdmU4Oh
         WA6p8EOz2Y9htRlM0khXt0B76PC68McpExi08v4O2cnez25ZmFnvMhsN9Ez1yDN/gEaL
         BB5RkWmuvWEtuEy0IkcXIuWNqmLQC8waXlHHeL6s5ElF7oJfNJO9ZJv03dNv5CdhayIN
         wUZQHJKTEInn1ZHoWHcgqmA0ZSZwCK1isMYk/AS4PCV5t7Zh58+syLMQKAzByfYZID/0
         ImSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762544709; x=1763149509;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJd4Lt7kd+i0Y3qfV8wxl3MYHl5ygopfsMQ71Ksl2t0=;
        b=KgygjL1RTec+HJwworJWlYr1mMCu93hW8FulWAJk0lnjA/mf+0jeHzHjJlqRP3jlcL
         20uEWyAnFNL34kT+ct7FnLVnY1bucA5hSrVMcCTnHQmiteSce97hOYSljVqdzVB7CWWy
         JG4ejLMJ0eF1fXUHI0fqAusx1/n1PZMmxpMWR2zEf3dpHC9r8b22HR9jacoYIiHBpxrc
         wg3c7bTs49WwKHTDMj/E5k9SfVcpesenj9zfcG6pI/EJ5AwVh51txEV/1BYt2RpipSf6
         bzeDfaWUttnIMASO02hLHW40FL89NuJdcpgTxiHmPGe+JwCLJm36M83JZE1VyJ77xqfA
         rKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWth5m70prxslbtcGIfAYQLjT7URUd8yydQRDJUPHsnnDch3hC740RoZs8e8kPF1nUHYs1GNd1Ux5Vkfps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO//XoOTxAOmIJTVcDVVvvJlETe3GQ9UQxqg4h7UsuZNcxvAxI
	gNNleMEiUGID2J1z1paYzhQco7idbzt/YcfZXnQLKPbja8GgpEqHiHhn
X-Gm-Gg: ASbGncvc9hmPN4L7bFO2adrydT+sCWrogKEjdENYaq40zwGsAj9xy00Dd25i1asNW0/
	e1eNzR34Zi6n+Eo38vTGNfju6knw2GMxEaDB3uQVlwCcag9rtFGLhzO7Zu5mJmJLk5hMbWZ3+Cu
	FZPFX2m4YLiHWqt+hF5LzAxXQ8Gb4iznEw9Tf5LflUyTaLb8iWt58trY5jS8GOesYK+pObLz9JC
	UeXr+LbowOQ6dTMxhVOAo1ihdfW1Sgu3D+uxeEAWuEFSRUPqEbs+YMrN34y4tsqrTRmfxrlk8J8
	HIIPpK+gavdQPkTY99F8nz8+GyMsUgm0b6Ug0RXkfd/A3PQXdz6q2hwNsun258lZ7Ixt+J0cKFC
	g9ut464+QMPDzEzZYgOkm+l/WbiyCuiN+icCDhWfeAZJHMEund6FLWsFoJEkaE8XAxJLVGEN/+9
	XDmsxuy1Ov9SKYx+k5NQ==
X-Google-Smtp-Source: AGHT+IFiX8juAEVF6aTi9i63b/PQSeOvdU+AnVPuYkFlsVgI/R4sPMc6j3BNKqpkZFA0b6LAUANSng==
X-Received: by 2002:a05:6a00:114a:b0:7aa:9723:3217 with SMTP id d2e1a72fcca58-7b226d893a0mr478395b3a.25.1762544709234;
        Fri, 07 Nov 2025 11:45:09 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a688sm3749017b3a.40.2025.11.07.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:45:08 -0800 (PST)
Message-ID: <4c33ab7a31ccbc1235bd183a5e4bfa4f94896c63.camel@gmail.com>
Subject: Re: [PATCH] libbpf: fix BTF dedup to support recursive typedef
 definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: paulhoussel2@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Houssel	
 <paul.houssel@orange.com>, Martin Horth <martin.horth@telecom-sudparis.eu>,
  Ouail Derghal <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>, Ludovic Paillat	 <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>,  Tristan d'Audibert
 <tristan.daudibert@gmail.com>
Date: Fri, 07 Nov 2025 11:45:04 -0800
In-Reply-To: <20251107153408.159342-1-paulhoussel2@gmail.com>
References: <20251107153408.159342-1-paulhoussel2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-07 at 16:34 +0100, paulhoussel2@gmail.com wrote:
> From: Paul Houssel <paul.houssel@orange.com>
>=20
> Handle recursive typedefs in BTF deduplication
>=20
> Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> Podman) due to recursive type definitions that create reference loops
> not representable in C. These recursive typedefs trigger a failure in
> the BTF deduplication algorithm.
>=20
> This patch extends btf_dedup_ref_type() to properly handle potential
> recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> handled for BTF_KIND_STRUCT. This allows pahole to successfully
> generate BTF for Go binaries using recursive types without impacting
> existing C-based workflows.
>=20
> Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
> Signed-off-by: Paul Houssel <paul.houssel@orange.com>
>=20
> ---
> The issue was originally observed when attempting to encode BTF for
> Kubernetes binaries (kubectl, kubeadm):
>=20
> $ git clone --depth 1 https://github.com/kubernetes/kubernetes
> $ cd ./kubernetes
> $ make kubeadm DBG=3D1
> $ pahole --btf_encode_detached=3Dkubeadm.btf _output/bin/kubeadm
> btf_encoder__encode: btf__dedup failed!
> Failed to encode BTF

Hi Paul,

Could you please provide some details on why would you like to use BTF
for golang programs? Also, is this the only scenario when golang
generated DWARF has loops not possible in C code?

[...]

