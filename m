Return-Path: <linux-kernel+bounces-776225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E28B2CA42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BD7B6F26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EB82D24AD;
	Tue, 19 Aug 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="atFNyqdL"
Received: from sonic312-24.consmr.mail.gq1.yahoo.com (sonic312-24.consmr.mail.gq1.yahoo.com [98.137.69.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28B1E47BA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623352; cv=none; b=SMDPuLD/H9SBuzwml+rHG1jlbEZT/hynx9+PFgqTtINLq0O3movQ9nDNInVAN5gpLIC5vZjASHcPvnqirbacBqUuT3O0R0gv+ptQ4c1MrnYY7D4SvhWJmmlJTbqC78e90Yjn7DfgP7ukXlrHN2GM2cUeYuBzfQyZCZ+96Ck8HPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623352; c=relaxed/simple;
	bh=ZzlugSwr1NuiDTXaRBuI6egiVVmhVYhSAWDLJ2hyFUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=foaG/pyY3FoOO95OoR3qLhGOumNFia5yWPRfMBmzqoRWS+XNQh3xGNQsQACbI4kzIw9FKRyqAjANkYfrG9UaUjmXn2rSxw3HpfAFKlu+hKgCoshXgxzCMSlaMpn0euQeZVoNlYvapMF6vwWele3h8QYhkqc5lZ/T4gU55Vmz0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=atFNyqdL; arc=none smtp.client-ip=98.137.69.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755623350; bh=A8SWyyT0DiX2Rnzy5SGMSBgCFA0refGm5qe5v8qneCE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=atFNyqdLLaj154yndYf2pLSz8xmL1kGjuzMh753hF7PdYEitiMSCr6L6GMgIi7vNZzEtgPr1mlBUNTZKBAv++Mt8v5OFUVE8PM93zrTFoHyYcrYvMKdHidte/zSMX1ptTTbswGLtuVn2kYx9JYaYK0oHOgavmSSpNKnbfXx1UobyeUgwKIm5l0R3yKmvDsHXGeQOiSe11yGhAvVGL+iS+6Yzp1wYD2QzNF+xkSKUBkfuabP4rJwn+acBPV42U/fWsqPLFy70OcThKiq2P25JQQvhiejSkvrrnImWi3EQqDVq6FJyUEccadEOswy6TIp7Nzjz1ilEPfcKp0Rf/4bWEA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755623350; bh=62L5NK4+2DTGnC5gXyjRzYsrqYJEtulUtjcQgLMhYVi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZRu6mH4W4yDHXtU6FVhoxL9PyYCt+R3ZQDRM5OgIWYi+sfeQRkIjp3Q25oj3ZVAU315gcbs/Sjw6rVv/eMzdWQWuDhlRmAwWI0cd0H8RJjkWzggcyndM3+CrrmdfJE3H6nCZdCcQH53GwY8foJKUmUq1A+i1QihgUNFrmYOP8Qg/GA0Ijp/a7PgeE98LYMP36fjD9s5biZd43ldyg+SqrBkkclGL583RL6/JkDoHENBqfHHtTth+zl2+byORdWOgub1CY3nBt9znfyRCB0/Z2AwjtGdnx+zxuH+jnr/jonuan0DbvDwFNutiHXcdj04xjsM02A9SENExM7D5YWRS5A==
X-YMail-OSG: 3mftnr4VM1lN0NAgHCOnPyNyN9yV1.nSXllhOSAFyQyekOmLRW9EWYQToQE5X8o
 7UcdkL1OuSohjdWNamCAScUg9.NNg.BWdlENSxXR2RRmhvQLDl5wUg0kNSyPPkgSo6HlF3c1EUCV
 0KNqf3bAnYBK9vtciSbY.LGpredRwMYTnHuttkpZjSqFVyTSwrByx1E_GqHIZF.pAxgVlJPOGMHC
 r3sVmmMTdtMSyG_XDtjGaIL2ZPwXBAqVY1J5O8cLcHOSeM7Clf4i4tQV3jfvSVED428arI5aJTVY
 aoqX.2WzTaxcJTiViFYU3YQPLNoObY_tH9_E88KqNM4JMJlnE2r_dvzxvmsG05ZJvUeG.nvV0Rmh
 rFpFpICM6.Q3XoC75kzenAon9jFtl4e3Tz1dHOsOzzb4.7vHozZlNbVaIFWdbJBT9RKpcsPhUlGk
 bCEkdz9TdyV0T8gKg.ifgoy3YryiQgKoVygkeRZXXsM8l.1y2eucN7rmOeMwopQiUvGVUsKyVRi7
 U0auA_FFdJtBxjEfVCxGRz5qhSHA1kpCB_ODm3RC2XBnxJROh2ZlmiWWA.Ig_MNSbgQYNo3ey6c.
 pNVfwEt.4wl4s.gNkyNDCfMIwlhD_Vlw3nun9QrOMjSGLcn7QhQA.W7ZHB_fm95F6IsoD6eIt6e_
 Ic7cq1lxwJuubt1Abmjg6_6tbrqXdz8y9yP.rbDk6QNl.SjDbuOjQWrKVvfmHisUc7mrTCMosRT7
 OlQhdGbTeEKWfgYMq0ZRzKNPwLATeAcWEamxBx0VGsgPN2_azMEj5ABlGNqIEO3VvJj3pQa1XndZ
 nSyErD.thxwNSwwVAQ6Fm2DiDs6nbV01KXbSa9p3M8mXmIl8FUZ2CfeFrKFV0VqCpMwV77DLzfsT
 oy1KJ6gOtpLqPTuPQYFeXH6dU0QGxaRCJgZtPUEaNQugxWhTSG2OEmlmqGRVYH5hxKN0x2wucgL6
 HMcHht70U8KW1YxxPfiE.cp1dRpUuVZ.3pPUTaMqYx75N9em_drcCyoVKRrqWx2n9oVVSAFm1GCR
 .IXABYTwcDoTlFTGQZ0D3QhutMmhG2jUNE0kjRBRmKuGJ0rn39b03IoSsy2xqdaCb_Cdk6UqxXEr
 uZSZvW5ivnu_3LHjdeBJ1QJDl9caqxPpeX1vO_RJpfX71AGXTjQVpEAzHehSYHekq6yy1mcajCun
 OVF5fldCON3RyWGx0txTucPzUp.Fwh_HKx9PwvkiTGFY5v9My3k7Qs1y2bx4wEPoKZjii08alhJG
 0yscs0Cac1zhWdF.Ih9j475mTeZYJ036TahKflzK0m2tO8v2N8DNUDciqBOjaCbJIy4mHLEpQocP
 s86dtR_t3nGg5GjfyMlE_Xv8A9uZuDmD7dkGjSDRp5.0KNEyUoOFhIYdKz9dJaHoAo.MLRt1VuhV
 qOtwWYj2D_CQdND0hPz51c6tYUB9qznGUTUBAx9_MzKp2jeXnqdpbmfVEM9QlyFzBpr2w.MtEYZo
 4FOlKICy.HchnVpQvyEVGg._Zl6vJIvgfzfVjL8MAIr24yanjETQ7r4BPZICfXNvWjj0Z__SEy0_
 ycfCeODNXeFYhlD7QZPqSvk3ChzPnC38C9in8h4EEnEqUUBs5c7yztpMRw11KFwuVaVcRkpHd6yA
 UnpL39ns6dQ7qJ0ZLEjvLCFuyiA57Nba12UNigjuO5LCrF2WX4ygZeZrvv8oDMB9aR0Jd6bEkk25
 Q4322QmsUbsfiKdwiCb46H0x2yEw8Aebto5zJH607hoeV5VC1QAwocnofvPh4.fL8B9mfsybKnC9
 PM0KGqZu8afJw8rSR2nhjLHki5xtB40zJ6jn2hlp1XDSldLAlc6OYfGTA9HgAx._7oTy6kxw14Zc
 ljpYGX_zzoQWgMl5iIkXhhJoURTwd5630SjSI3JfYv2QjjkWoCjVI.9mkYcsPIrl0IeNiDe2EQLX
 a5kkGMtzMwt306jB4cMoz_IkXJjVbHIJQzXgXTUkLXXkP9FK1e79q7RjVnM_kP0hy61h46swCXDM
 0t4OPbWJryETp_NJ9MUOz97Z8iW02adIsiZwQHm17jVz1zsqozuPIWHfk1I8BFSEnazeYORuZFTc
 qbdnYfuZDyxwwQCNHw3purDihdHrP4.Da0Pj2Ft7J74OqN0rjJABIQbhxReITEz6tleSMl9gPAcy
 tplyl0YYcrexDSeFJs1a8SMfZkCtlvAS4Q1.aQcp_S5ICuOR5riN_mpFxbmXhjbXiIgyMb1K4.AL
 xTtVYkabv_S0E3q8zuQBY.kQ39L1vfpWqCplbB4Tc0ChuzbyvwQ2nxzLC7i97Ww--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 014cbe4a-0fbd-4d25-84d7-25c8930f871f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Tue, 19 Aug 2025 17:09:10 +0000
Received: by hermes--production-bf1-689c4795f-67vx2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d23dd5995e0d4828092d9660ef3af68;
          Tue, 19 Aug 2025 16:48:52 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH] fs: Add missing parameter docs for name_contains_dotdot()
Date: Tue, 19 Aug 2025 17:48:22 +0100
Message-ID: <20250819164822.15518-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250819164822.15518-1-adelodunolaoluwa.ref@yahoo.com>

Fix kernel-doc warning by adding missing @name
parameter description for the name_contains_dotdot()
function.

Fixes the following warning:

WARNING: ./include/linux/fs.h:3287 function parameter
'name' not described in 'name_contains_dotdot'
Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..48a726839e22 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3281,6 +3281,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 
 /**
  * name_contains_dotdot - check if a file name contains ".." path components
+ *@name: the file name or path to check
  *
  * Search for ".." surrounded by either '/' or start/end of string.
  */
-- 
2.43.0


