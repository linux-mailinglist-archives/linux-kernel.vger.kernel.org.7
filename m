Return-Path: <linux-kernel+bounces-761501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A92B1FAF8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 18:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17657A9FA4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085D0267B90;
	Sun, 10 Aug 2025 16:00:51 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3DF2C181;
	Sun, 10 Aug 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754841650; cv=none; b=SNNMXo4fqIseaGRBghEsnxw5KHreJbrIrPikmXlG37db2kX7ZP7HVOAhjgbIUm/Y6TCynzE+LKhHJ1KFGzgZ+DXpS1ntkmtGTnLHe2LIjgDq/KxgaaIGCz9nTxfKYCkJ0r2+6Ys4/pZE0gGbcUV0nW0j2ES40e36CcUC6CxFz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754841650; c=relaxed/simple;
	bh=NwsNLfO/+MFsOtjy/2VZNi2TOkyj58Atsa8ZBa7OwhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePsXTBXY1QPiWpqu188DeyPEB7NMHE3DgruA8Cs29CUGWKM3GKEbVH+OdlV46DIPjzb/r71eF3AmQH3C90yQEbe19bt2U50bv4lihkmLaT1X/alZlpIc9nhoui4yeqgoZN90SLjirWwhYKaTFhJgyJ/JUlt9Yh2G30ioDAi18eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DAC411A054F;
	Sun, 10 Aug 2025 15:45:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 485A220010;
	Sun, 10 Aug 2025 15:44:59 +0000 (UTC)
Message-ID: <bee3cea19d9fc1c97b1816f516fdd5283cebc1e1.camel@perches.com>
Subject: Re: [PATCH v2 1/2] README: restructure with role-based
 documentation and guidelines
From: Joe Perches <joe@perches.com>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org, 
	konstantin@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, workflows@vger.kernel.org
Date: Sun, 10 Aug 2025 08:44:58 -0700
In-Reply-To: <20250809234008.1540324-2-sashal@kernel.org>
References: <20250809234008.1540324-1-sashal@kernel.org>
	 <20250809234008.1540324-2-sashal@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 3a77nyes4o3ndiwsq6jfta864pmfa46b
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 485A220010
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+hb8m+D8wj5BHAfBujPm1MlO2IqBMyTU8=
X-HE-Tag: 1754840699-118705
X-HE-Meta: U2FsdGVkX19EkAO2csveQD8LvL+TybIV+U2PpyegGR42tPv/ZEG1N4TIHvRxT5+VXRwqBQ8uDV0aMlLa6XsVui/NYw7Lcf1dyUMqJ4klI+BzH03VzZETSLbpVD+9zliQDA5a72unGO/9D8fPF6frbnlN/LPbLcSA0WM5jmkE/7f4YxAsHuYLjN9T4F0+pXYhAmkbAUmHfJj/tqy2xzyc1XEDDPB+baBDbMp3og/5O25AZ/PGmcx7erTdsrclLEcD2yvCftqRM5h2bgXe171yX424MyInDPMzRiSovN9o+MQJ+n5UtzpZH1lewYvb1Qn78EkBeALLxzUnLO2LaRdKTT2f3fSnbVRM

On Sat, 2025-08-09 at 19:40 -0400, Sasha Levin wrote:
> Reorganize README to provide targeted documentation paths for different
> user roles including developers, researchers, security experts,
> maintainers, and AI coding assistants. Add quick start section and
> essential docs links.
>=20
> Include proper attribution requirements for AI-assisted contributions
> using Assisted-by tags with agent details and tools used.

Nicely done.

Perhaps the 'Assisted-by:' tag should not be limited to AI
assistance but could also be used when accepted notes were
given on any revised patch submission.

Oh, and maybe a checkpatch update like this?
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef3..d17661141da79 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -641,6 +641,7 @@ our $signature_tags =3D qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Assisted-by:|
 	To:|
 	Cc:
 )};


