Return-Path: <linux-kernel+bounces-847633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B623BCB50E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC653AC973
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A815214A6A;
	Fri, 10 Oct 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pPKUTpvl"
Received: from sonic316-55.consmr.mail.gq1.yahoo.com (sonic316-55.consmr.mail.gq1.yahoo.com [98.137.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF41F4281
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058362; cv=none; b=hs3scqyPt0oQkKrQIr4wJo3SBbUhfcx9K7l5/CTslM6QQqXk8PfF5iBooN+lW7XzD3maZzdKvD9YWL6/KXMSxNN63dJI+NX6sE0Y38gDzcAkeL9yasiOjFyNH4KVLUIT9T/meYftRtyjR+2TCdtLQik62MojsJ56checsVCtUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058362; c=relaxed/simple;
	bh=/hMfUOIeK9GD9x4vXhTNoREyWRIX0X+0EK95NCRkb4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=g4qeZjypFoh6DBEOq+Kn9CcFdxz7ny6qc87+q5HckZZ04+qJUjMMLLJyDmQF+Hwg+YFyJphDR1Ga8SCCSTZwabOO8FehoYOZi3D5NKQiUqW1nK2x9eGb22MbB1MMGUraSE7Q3nDAbSIGytpfGHAS5E2CUMQr2t4CjRQ8VjW39ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pPKUTpvl; arc=none smtp.client-ip=98.137.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760058359; bh=0VTdNEpFRWjnOOzcXbrlmV0h1KaJ09ZXiLQBWRMC6P4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=pPKUTpvlaVOak4PQxpWttdJACYmcJYtphGGe50SycBhGtKElkxFff7YykzeoZXnyYhH1JLVJnkimY2OjNJxm+u/2Nz9Men2MsHcRwY+k0zhb0eMfeP+UTscicVHkXaAjGGCa1WE+NFebXyyMUURADykeYvuZ23+C7qXrPegvtsR/wlkY5OyP6ajwNfA/uD61xHSxH18rI/hg4G+aKDdpE7Pg0cwAHuCXJxrWp4Ny+J3G6e9yQHQyFnRoACCgzuFXC+L5s2o5v8eoVAoAj8wy/rsRbYzqD6NwEEMVZk3L/KBpVYykhzYX2n9+9lRCYIOERK8orzrppG8ROlYo7VbzXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760058359; bh=f9onEI4lcpxFlgSZrxrP8CGHqi9leEybBHPuUY6vkbc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aO3C9QPYoaLeKuvtwDK8qXXirTvy9f349MVW+QtaR0c24hRauXgwtZpexo8liTt/LI8Cajj0gWuU4dD/MmLaQxLx7gwIK7ey/U2PKdOsnBZetdGF+/AOX36N96bbrsAbwdya168Rv4/lzGdeqW0O7G9/tMx3cHSNBhlxwHAOKmySnShfWMNJdN/GHAisocsFjhxQAmAMETJcbNxUhSKOpuxrqhuJ9RVscpR/ZnO9TTuk5gr7PE+6WLpTm/c+sbDUiZkUj23yhdlaRsxndp17eBm1kImocjMkku+cTKH4A3AFCJCnzh3rzjxU+zu5u/3q7yXQWivRb8sqtRWkwqsr6g==
X-YMail-OSG: VbSpB3AVM1kFrdWXjzDYStmyabFzfBauQUcwFj47wWqxZxJitX1xO3ebNu4krFG
 RYQR8ULwOVgn.h1u8WtC7pNSFezlkCIP5ViSBedj010XjuCG41T6P7hnXSOyPvRuOyvo086giPHs
 QIds0t..w4ib.odZn2LDZjDhIHWe2fnN5rvSeXreWlwLP1dvLDMR5DGd.K3IM.9it2p7NkAu2Ppl
 FXVgrWOIpSZHW8KNUgnRmlqRbSLqjaFONg3F7CxdWpkgsItxyb4b3D9SLH5j9..RHFb.VfK1L.nT
 McWUQ9L_l8qxMmjrEl9nMD8FGp9m8WtLasAfs46DXOz8Dkxvv0iw94AEH6h2hIvnZgBj8IAP5K3D
 hxkPLHwnEJGiUHqbD5KVyuzYDSgwQsv1xTvfrV5k6KwN6oSiRNyT6Qt8by3ppQ0LqIri.kw4qJdR
 aFYkgmrkK_5xykJLnE2yikjGijnS0jsvgwNc42Ocn.Fd_EtgV2u9LJV18nxPhQYyF6.mtJ7h1Z7I
 4Qy1xfTpJQPzzDcVLiIPvlIi_rQbMMIfqO_ODX0dnCrMA8f0XBjzrEuSoRWsUkvT5Q8el4pyU.Sx
 jqsniHM1cJwIMMZG1BePtJTJVGeJ9vayJbK1AxPUOFvAxKyQ5AZtNuFC08Ns26RnGEHjtJshZiq8
 SOy6wM4j12ukM53E6vd_458XVaijSMPgMRIYUGr0d9.r6kqJr9xQl8qAxAcEJs2VHmVofMM1hl0o
 iCdb5TyRTUWXds_TQLL9cDTOJxIAHGyzUcbA8kKhROV400Ilt00SkvQjhBPwVts2BDqzhAua108k
 7zWYQ5QBBIEfpP16AdOOoaaRvAcNkpr1grweqrPYfKS0YIpH6rzb.Rfva_FS7WovrEI4yy38Gi.I
 8sy.MJ_aY1B0wph0Lwrk3wOeob2C7gKtPCIGqS5ccagJ7qk2fcB3r5.AfD68qxpdTVEaLUZaG_Nv
 qmWBYb3koT3A93Wzs4sgGmDf55hgOdMvEjcNLH5SGnY0W1FJqibmzN.XciwD0wnsF1zeQS6433Bf
 t7FMM72C1msUZ.2UiChbJusz9Ir73UuR9R6PViDQjlQ1IXhUdSMeMo241w6EMCPauzohk9qvXqnK
 hWHzA5pMm0ommaeD7kUHiI5UFkw3TADMdYBcW9RnJjmSeUGTxGqxLuT_IdtZ_rpeXdBMyXWybUHM
 GEyjdHkagMqG0VuoWeyl.ijKZzp728eCkgeBZA31VUICKt_DUc4TEKOLtwHDLwSENS2MIKfiohp.
 Wa.Xht25RzdeqCsaB6Y9XtzqCFu559E7PXWSE4rUDrQ2onEMXdZdJhJXNU213eieycpnZCHJXjPK
 bPJENJYq5dootkYjBkVftgyqgRrSk6W5Ovm7RwAmaJ5Qi.PF2nxheNbxLZZVMj9iOS6Juj98I7LA
 9Eexvnv_7XDhaorhNZgtiVa_oq2jwQdBE_Zqq9aKQj.GSJ0tRIjryZ.gfSPZH78xaSkD..bhrEXn
 OxuW81QoKcQJBL6LJSX6.08HG.X_DoraZZPhKHDtEJIfJEwODyca4iTdNiCbQHFRA4cI.yaYCUYN
 TaahGVo0qXY0UDgjd1uHCWBzxg6OdvWJnigmwu2q2nvHYJ1pT95pVs6JZDI98g2jkxkrIBVU9qOb
 Gc0v.rXdykiDft6kCBlc3HKS..Me0IInEiS.87.D_lsENtG3Fz5hsFZWoin_CXpiVO2w7lbGpqUt
 MQ5Mb1KTVoOoL7OcQcMWq2GheLtdDQs62HC4_nhqFqcFo4Yb9DMoKkY.qfa4wGWKNzjEVWf2EiBW
 kUVoSDKb0BT1sWoCbRyhw4tTn2azcLSZcHIyYk1nnMhqk5Ve3GsX1x02S3CFMdTgYn90GgSyP00A
 1xpgx.dO7jed9GA4eek4.APdgY32wVuhHu.ke__oEw97r6CNfV39VyJ8lIy4j.dL9MW6f7bBhq1H
 u7jscG9HxuOLJPMf92gTSBtYx84rFnspRcbCnbKhiLaeckhJWAic1UgHjCXPgXZKCoy0KGXmlIdu
 wuhFYaflNX1_W7qqs17TFf_SvbVSoMxCJqjxmmH1r.daaMTd3ksAAnMl3Wf7dTWLDs8oVtkegx.9
 azASxo8rzljyv4.6aXBVhtWPlwHha5OOcAvuCPoVk08_rj3cJFyUGoYZeWv.IoRRsYoCEJ2EKE3I
 QDw11LOeY_DY86jqNA6VqCLXdJXGKTQGQpEYmuWtmlPj0JF1e.cHZ.6u_bNLh_PEYjPrGvRbvK78
 QxCWJxQDoHB2yQeUOXI8nMu7_HUBRO0qHWmXArYrrRFOU1QogfnpbPH.qgfZ7zsTUqZBV_DGIafK
 pcnLWWaeMuHvODd4-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 6cc0e7b1-f593-4cd8-9102-8f489ef4c6b3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 10 Oct 2025 01:05:59 +0000
Received: by hermes--production-bf1-798569fcb9-27qrh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3c7b071a36dce4930d289eabdfc11d66;
          Fri, 10 Oct 2025 00:25:31 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH] drm: rename drm_ioctl_flags() to drm_ioctl_get_flags() to fix kernel-doc name conflict
Date: Fri, 10 Oct 2025 01:25:20 +0100
Message-ID: <20251010002520.359824-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20251010002520.359824-1-adelodunolaoluwa.ref@yahoo.com>

The function `drm_ioctl_flags()` defined in `drm_ioctl.c` shares the same
identifier name as the `enum drm_ioctl_flags` defined in
`drm_ioctl.h`. Although this naming overlap is perfectly valid in C —
since functions and enumerations exist in separate namespaces and do
not affect compilation or linkage — it causes a symbol collision in the
kernel-doc build system.

During `make htmldocs`, Sphinx reports the following warning:
  ./Documentation/gpu/drm-uapi:574: ./drivers/gpu/drm/drm_ioctl.c:915:
  WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:69.
  Declaration is '.. c:function::
  bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'.

This happens because kernel-doc processes both identifiers (the enum and
the function) under the same name, leading to a duplicate symbol entry
in the generated documentation index. The build system therefore treats
them as conflicting declarations, even though they represent different
entities in code.

To resolve this, the function has been renamed to
`drm_ioctl_get_flags()`, which both removes the naming collision and
better describes the function’s purpose—retrieving ioctl permission
flags associated with a given command number.

All affected references have been updated accordingly in:
  - `drivers/gpu/drm/drm_ioctl.c`
  - `drivers/gpu/drm/vmwgfx/vmwgfx_drv.c`
  - `include/drm/drm_ioctl.h`

No other symbols or behavior are modified.

Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 drivers/gpu/drm/drm_ioctl.c         | 6 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 +-
 include/drm/drm_ioctl.h             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index f593dc569d31..313e8bb7986a 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -912,7 +912,7 @@ long drm_ioctl(struct file *filp,
 EXPORT_SYMBOL(drm_ioctl);
 
 /**
- * drm_ioctl_flags - Check for core ioctl and return ioctl permission flags
+ * drm_ioctl_get_flags - Check for core ioctl and return ioctl permission flags
  * @nr: ioctl number
  * @flags: where to return the ioctl permission flags
  *
@@ -923,7 +923,7 @@ EXPORT_SYMBOL(drm_ioctl);
  * Returns:
  * True if the @nr corresponds to a DRM core ioctl number, false otherwise.
  */
-bool drm_ioctl_flags(unsigned int nr, unsigned int *flags)
+bool drm_ioctl_get_flags(unsigned int nr, unsigned int *flags)
 {
 	if (nr >= DRM_COMMAND_BASE && nr < DRM_COMMAND_END)
 		return false;
@@ -935,4 +935,4 @@ bool drm_ioctl_flags(unsigned int nr, unsigned int *flags)
 	*flags = drm_ioctls[nr].flags;
 	return true;
 }
-EXPORT_SYMBOL(drm_ioctl_flags);
+EXPORT_SYMBOL(drm_ioctl_get_flags);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 8ff958d119be..fa4644067d46 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1257,7 +1257,7 @@ static long vmw_generic_ioctl(struct file *filp, unsigned int cmd,
 			goto out_io_encoding;
 
 		flags = ioctl->flags;
-	} else if (!drm_ioctl_flags(nr, &flags))
+	} else if (!drm_ioctl_get_flags(nr, &flags))
 		return -EINVAL;
 
 	return ioctl_func(filp, cmd, arg);
diff --git a/include/drm/drm_ioctl.h b/include/drm/drm_ioctl.h
index 171760b6c4a1..585dda7550b0 100644
--- a/include/drm/drm_ioctl.h
+++ b/include/drm/drm_ioctl.h
@@ -164,7 +164,7 @@ long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 /* Let drm_compat_ioctl be assigned to .compat_ioctl unconditionally */
 #define drm_compat_ioctl NULL
 #endif
-bool drm_ioctl_flags(unsigned int nr, unsigned int *flags);
+bool drm_ioctl_get_flags(unsigned int nr, unsigned int *flags);
 
 int drm_noop(struct drm_device *dev, void *data,
 	     struct drm_file *file_priv);
-- 
2.43.0


