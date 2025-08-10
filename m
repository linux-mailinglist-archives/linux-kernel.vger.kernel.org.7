Return-Path: <linux-kernel+bounces-761607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FFFB1FC71
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 23:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF1584E157B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AD29B795;
	Sun, 10 Aug 2025 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fpl3QDYw"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AA29B239
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754862168; cv=none; b=ihXMMkQ4DRrcNWOvkf8hNA2Gd9HCkOr1oarf5kIcjW2SCbmmBu48nP8K4CXr4fVm15+VeNg9P6aAXL+IrMrqbSzvD8PHgcBGIlmcSfCpPWHbinGtHieu8c8FkMkww7Ij4yYMtrIknY0/Tjx3NgHjtzrt42oUNhuScLfW3+Pm3y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754862168; c=relaxed/simple;
	bh=eLU24AtZOFQxNW5c2K1PQI958AqqGw9hRMJ9aDiPe98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOyGLSFaDhyh2APtkbvzi2joNvK8sGhdLKFHpsOJokGjjLOB/Lv6S6H14XGmXn0jTKwIOxKSVp7J7DsxMVd11yUA5G7gg/+Y0zAm4K4VZXncmQ4qqoistCZv3+YTOYIGJGfimPGSnlW5xjiP6dM6WstvJxKcJJUjbLop+sg+0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fpl3QDYw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754862162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T1mVPTbusFcjEaAEuz+p1xMtyzLMl/A9Q2xzfqZxEdU=;
	b=Fpl3QDYwf1g8N0XxuW+lMM+HoOft7rj7grBb/l4txe+YMV0/x8jrhm+FZY0D4nn1lQrgYp
	F4OE0O3JPSMeUCV94uOe+wto2TE7kdW+VIwhNYlzdTEZemc2FFy/FxP9rnMTH+drq5txx6
	JluYIYQnx2wrTqPI9GVZ0kw7i+8qtCE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Weidong Wang <wangweidong.a@awinic.com>,
	anish kumar <yesanishhere@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: Call strscpy() with correct size argument
Date: Sun, 10 Aug 2025 23:41:05 +0200
Message-ID: <20250810214144.1985-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In aw8xxxx_profile_info(), strscpy() is called with the length of the
source string "null" rather than the size of the destination buffer.

This is fine as long as the destination buffer is larger than the source
string, but we should still use the destination buffer size instead to
call strscpy() as intended. And since 'name' points to the fixed-size
buffer 'uinfo->value.enumerated.name', we can safely omit the size
argument and let strscpy() infer it using sizeof() and remove 'name'.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/codecs/aw87390.c         | 8 +++-----
 sound/soc/codecs/aw88081.c         | 5 ++---
 sound/soc/codecs/aw88166.c         | 8 +++-----
 sound/soc/codecs/aw88261.c         | 8 +++-----
 sound/soc/codecs/aw88395/aw88395.c | 8 +++-----
 sound/soc/codecs/aw88399.c         | 8 +++-----
 6 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/aw87390.c b/sound/soc/codecs/aw87390.c
index 110009616966..ef6f64856988 100644
--- a/sound/soc/codecs/aw87390.c
+++ b/sound/soc/codecs/aw87390.c
@@ -177,7 +177,7 @@ static int aw87390_profile_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct aw87390 *aw87390 = snd_soc_component_get_drvdata(codec);
-	char *prof_name, *name;
+	char *prof_name;
 	int count, ret;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -194,17 +194,15 @@ static int aw87390_profile_info(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item >= count)
 		uinfo->value.enumerated.item = count - 1;
 
-	name = uinfo->value.enumerated.name;
 	count = uinfo->value.enumerated.item;
 
 	ret = aw87390_dev_get_prof_name(aw87390->aw_pa, count, &prof_name);
 	if (ret) {
-		strscpy(uinfo->value.enumerated.name, "null",
-						strlen("null") + 1);
+		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
 	}
 
-	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
+	strscpy(uinfo->value.enumerated.name, prof_name);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/aw88081.c b/sound/soc/codecs/aw88081.c
index 3dd8428f08cc..d61a7b8c5470 100644
--- a/sound/soc/codecs/aw88081.c
+++ b/sound/soc/codecs/aw88081.c
@@ -914,12 +914,11 @@ static int aw88081_profile_info(struct snd_kcontrol *kcontrol,
 
 	ret = aw88081_dev_get_prof_name(aw88081->aw_pa, count, &prof_name);
 	if (ret) {
-		strscpy(uinfo->value.enumerated.name, "null",
-						sizeof(uinfo->value.enumerated.name));
+		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
 	}
 
-	strscpy(uinfo->value.enumerated.name, prof_name, sizeof(uinfo->value.enumerated.name));
+	strscpy(uinfo->value.enumerated.name, prof_name);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/aw88166.c b/sound/soc/codecs/aw88166.c
index 4f76ebe11cc7..28f62b991ef2 100644
--- a/sound/soc/codecs/aw88166.c
+++ b/sound/soc/codecs/aw88166.c
@@ -1478,7 +1478,7 @@ static int aw88166_profile_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct aw88166 *aw88166 = snd_soc_component_get_drvdata(codec);
-	char *prof_name, *name;
+	char *prof_name;
 	int count, ret;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -1495,17 +1495,15 @@ static int aw88166_profile_info(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item >= count)
 		uinfo->value.enumerated.item = count - 1;
 
-	name = uinfo->value.enumerated.name;
 	count = uinfo->value.enumerated.item;
 
 	ret = aw88166_dev_get_prof_name(aw88166->aw_pa, count, &prof_name);
 	if (ret) {
-		strscpy(uinfo->value.enumerated.name, "null",
-						strlen("null") + 1);
+		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
 	}
 
-	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
+	strscpy(uinfo->value.enumerated.name, prof_name);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index fb99871578c5..de11ae8dd9d9 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -819,7 +819,7 @@ static int aw88261_profile_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
-	char *prof_name, *name;
+	char *prof_name;
 	int count, ret;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -836,17 +836,15 @@ static int aw88261_profile_info(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item >= count)
 		uinfo->value.enumerated.item = count - 1;
 
-	name = uinfo->value.enumerated.name;
 	count = uinfo->value.enumerated.item;
 
 	ret = aw88261_dev_get_prof_name(aw88261->aw_pa, count, &prof_name);
 	if (ret) {
-		strscpy(uinfo->value.enumerated.name, "null",
-						strlen("null") + 1);
+		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
 	}
 
-	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
+	strscpy(uinfo->value.enumerated.name, prof_name);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index aea44a199b98..fb563b4c6971 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -175,7 +175,7 @@ static int aw88395_profile_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct aw88395 *aw88395 = snd_soc_component_get_drvdata(codec);
-	char *prof_name, *name;
+	char *prof_name;
 	int count, ret;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -192,17 +192,15 @@ static int aw88395_profile_info(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item >= count)
 		uinfo->value.enumerated.item = count - 1;
 
-	name = uinfo->value.enumerated.name;
 	count = uinfo->value.enumerated.item;
 
 	ret = aw88395_dev_get_prof_name(aw88395->aw_pa, count, &prof_name);
 	if (ret) {
-		strscpy(uinfo->value.enumerated.name, "null",
-						strlen("null") + 1);
+		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
 	}
 
-	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
+	strscpy(uinfo->value.enumerated.name, prof_name);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index c23e70d64d0c..58846feb013d 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -1831,7 +1831,7 @@ static int aw88399_profile_info(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
 	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
-	char *prof_name, *name;
+	char *prof_name;
 	int count, ret;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -1848,17 +1848,15 @@ static int aw88399_profile_info(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item >= count)
 		uinfo->value.enumerated.item = count - 1;
 
-	name = uinfo->value.enumerated.name;
 	count = uinfo->value.enumerated.item;
 
 	ret = aw88399_dev_get_prof_name(aw88399->aw_pa, count, &prof_name);
 	if (ret) {
-		strscpy(uinfo->value.enumerated.name, "null",
-						strlen("null") + 1);
+		strscpy(uinfo->value.enumerated.name, "null");
 		return 0;
 	}
 
-	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
+	strscpy(uinfo->value.enumerated.name, prof_name);
 
 	return 0;
 }
-- 
2.50.1


