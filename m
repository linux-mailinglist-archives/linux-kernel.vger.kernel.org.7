Return-Path: <linux-kernel+bounces-856926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE23BE577A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701211A66802
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA82E175F;
	Thu, 16 Oct 2025 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq37NCE6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53721CA00
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647989; cv=none; b=poUDFSClTc6q9oMdqYht3DiYjT2mCHEC2Yopm7eK/8ru3QNGWUOwea5sWr1U7K7Sezwzt4pzSSQcDvMg06Kp277wXEmc6SdIJUtnjrXWNifaxT1J3LVPSAu6lohvhHky87NTDD81TUDX4hDVkPAE1/ayVfWhZdim5nx5DSyHXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647989; c=relaxed/simple;
	bh=KjSibwBEl5RvNt8FdRA6/VLAHMFHa4TcPKtGguhAw/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T4PoYCFhx5AYmMBDt8GjjkE82c5y3fYmwC4FTVRp7+CAWZli+DPA4m9XVPEfIGe2m+UTVNNbtiTg8JY7Ofp9TPmXz32dGFGaejf4M7AwzEhHosNn6PmT8D3UPxJsCozkk+n49ITIpkJYu149lngD+Hz4w9ApzE/00y2DqkKmmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq37NCE6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290aaff26c1so3002845ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647986; x=1761252786; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUGdHveixQiipUVAjag5n0t7zrVAHKQtIWI+mfEMlkY=;
        b=Tq37NCE6PR+3dPBBJ31OiUdSt7MY5H4Tj1pP9/Rkzl3I/IMK5jrEniH8y2hKIfkre/
         BSvWkVyLGgBJkWZYxMxv/0t/8euSxPQqnD+GRlS50ipLsSxbfK2lZiENtqppI3m034HV
         NY1LYD/sM0Mk20W9yKtizJmeFk02T0GtuPR/oZtqfO74UfiaXvv0hXgfVngcH6BRn9Tb
         MeFc5lfLev76ECHxhE20tHuvstb6woXcEeKFy3e8ZWDJyh+FXSa6aWzXvN7J5bdapHKi
         9LUc3Q7/4m9tfvXMKwYOWO7H6kvQA+FPY1qDPVw2RgjcMwMO6iu7iI1EqLRjI+tNj8BJ
         5q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647986; x=1761252786;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUGdHveixQiipUVAjag5n0t7zrVAHKQtIWI+mfEMlkY=;
        b=CKwlmtq533IbaetpNcQkqzE6MJ6AnqjbFNkxBvJSaXqA3pbctQHHq9cZJ5FawwcxbF
         25wt9GrfSuQwPzZNcFbv8ck+a5pnxSeyxrMBTAIJIi4kgYYl4HmUvkJAE8lGpyvP567O
         a2DGSp68+oSHRDfw0PJvCLfv6GOL9KxQmwSl0kh+gMpd4f1+yAyjKpji/xH558uh9EFo
         /jErLLykbk98Sc07jM6XKxj+wt8orm7XjcBPTasrShGNjXG/V3jA71pUuP+LO6KARwXf
         Q0MgivRMfK8dYn6+nku12n0ZComDB5bXZ+bfWPCDu4h7YwGkDv7JHc+pD9A4x6ykwxlb
         ZPIQ==
X-Gm-Message-State: AOJu0YytWq0iWcRPL4Fv6o26ZZkrRVxqdeZ9Fqhc/fk6v5Hn7l+sGJ1A
	LOiRG3uz5OV6o6dbXRNn6TLDzwe+UiD8Ukdb7/f0sU4PqNDn5tzQpjL+SxQ98H8Z
X-Gm-Gg: ASbGncs2nvBgdJlskZgMVEV2E1uySp8bt4uicfRuZ6Ix7m04iRQ4qK9q+zc7SupyDya
	jtpnq/kh4XbhpGf+bNRUDWChcoJLUWzlWM++h0whSYAHfcBs1Tpdvqt8kn0WtafORvsm3iaDTTb
	/nbiPhEYTTsms+gBIelm5Z9vUC3doEOuyzAehnkQ7uVJQQGCTDg8FhXQMQGD1JTJTE28Tp27EB/
	qwwkyvfW1kIzQW1BBHgpZ1PVCo2lopUtwGUrzMJbMgExafOhbIeERLQrhpEowvW35CFZoxChxkQ
	7eyPeGPoR7aS2FPWhBDN++MN1VtYo0pzUuHsPFqUxQb26Eam1eOGN1JT0J3XTBdE+AyZTvw0wPE
	c4tVhKHnVATqhsOISbA9Z0UWFSMEGme9BlS1wI7LgV0xcpA41zvdhZPEnn4PLxsJUj8Rk4FA65A
	Hg0Im+1A==
X-Google-Smtp-Source: AGHT+IGFqrhuRDzLp1B7vKAD/h5TSqISSfWh+qG6S2EB/f+0a7wn6hO5xl/a2yDTx2gN3DmjnP0BDA==
X-Received: by 2002:a17:902:f645:b0:290:c3a9:42b5 with SMTP id d9443c01a7336-290c9d1fdefmr7632495ad.5.1760647986361;
        Thu, 16 Oct 2025 13:53:06 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:85d:f376:d78:d2b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab1ca0sm40015035ad.96.2025.10.16.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:53:05 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:52:57 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, 
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH RESEND] perf/x86/amd/uncore: use kcalloc() instead of
 multiplication
Message-ID: <455fb1db8ab0811d2336e0ec198c728a0c703be9.1757744812.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vqsldrqglnjee27m"
Content-Disposition: inline


--vqsldrqglnjee27m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH RESEND] perf/x86/amd/uncore: use kcalloc() instead of
 multiplication
MIME-Version: 1.0

Dynamic size calculations should not be performed in allocator
function arguments due to overflow risk.

Use kcalloc() instead of multiplication in the first argument
of kzalloc().

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>=20
---
 arch/x86/events/amd/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e8b6af199c738eb00b..d08e3054461f2ca07a 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1036,11 +1036,11 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *unco=
re, unsigned int cpu)
 		group_num_pmus[gid] =3D hweight32(info.split.aux_data);
 		group_num_pmcs[gid] =3D info.split.num_pmcs;
 		uncore->num_pmus +=3D group_num_pmus[gid];
 	}
=20
-	uncore->pmus =3D kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
+	uncore->pmus =3D kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
 			       GFP_KERNEL);
 	if (!uncore->pmus) {
 		uncore->num_pmus =3D 0;
 		goto done;
 	}
--=20
Cheers,
Joey Pabalinas


--vqsldrqglnjee27m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmjxWykbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEKqB7vQk8aMCFAwQAKq3PKRByKJhX2KwbQjk
skfl5xlEZzdfp/hFYftBkM3B62WE1USEIKxcUsdtDOoIkMLU+7gbUYtBpyb8PlA1
8eMRVs8f20cOvBD9/9GKtRqXia4kK+YwNMoQqqzmN2LfSMobw/4f5IUnQw250/S4
IZySErp9DrJ4XM94qp4F9RiMXHGQXBx6EhX2iKuAxnY20yxIIAp3OVw54zRYzLxI
5gkMT311MxPorlzTHy0I+O+lpQtSS5pnTioBWB4B2GBELCAEIQQXbpfVx3U1d4aZ
Bdr1x0Ek7zp/87L9z8oNGuzxxnhvbAPOzCIJWYbzDuoCRYrwbsQ+WSm9HnoK+9By
2PLb0bzL0Gj8GCXAUnK11A3tJ2ldR+v/xDkdRk3Z9PafXUBGQTMBmzvFKgPXXcJx
CSMoksqb9ijOM7ynK8cG6APcJDva+VJGhrXWoapz+8yd7yE8MNUB9hgDgj3pijZj
qH5hByVhslsx+8EwbSzu+QNwSdsos9H+TLriOCWyI2wSkclPXLSzVV35qj4oEGoD
6Oks/FWN5I/k/26Z4YpQLeONI60fTY8JnABrknFF3Q33WOgo9xouqv/emR7SN+iU
zbpN9MDmt6IOZAmbryanWcQlwInbhFUkINxy7Vn2aPINPod6oksNB4EaHipW+7mW
00LBepAkQSu0EPa9u5iq1hqy
=irL1
-----END PGP SIGNATURE-----

--vqsldrqglnjee27m--

