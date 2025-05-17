Return-Path: <linux-kernel+bounces-652238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E4ABA907
	for <lists+linux-kernel@lfdr.de>; Sat, 17 May 2025 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8742C7B43C9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 May 2025 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5601D5143;
	Sat, 17 May 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oKWoLrX2"
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4A1DE8BE
	for <linux-kernel@vger.kernel.org>; Sat, 17 May 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747472210; cv=none; b=LO4uL//70RS4ROR0I40X40r3YyFNXSEFRSNm0M682ViogxXs3izA+/apdXoipJrl6ZdNTlVaVPH6gEmX7YUQj830tvFMZf4iAadklcVHBuNcfw/K2OcdMw3zUxohrjQ9XKqU4km9DxOo9P/3sOyT3u7wBvU4H6/Ju7zVjG2TFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747472210; c=relaxed/simple;
	bh=T6CpA99EceTxGXCLNGvZRdeEWeOLwjsAfdaThogeYfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=JbxBIlWKgEJeda2sJxeguBn0MdHhuUzrt3Tl4opPyAmJoC6rP7ojWmO12Wb7tSXT4gf38Vu/0k8XYfTWJPBkLrc9P9ns420VoUWNbX2xy/E57JgKibeDkHEUrbANxiLVcyp3MSeRbN2pFQYjRigmhFzm+1gLqHy/WhGFD+QksV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oKWoLrX2; arc=none smtp.client-ip=106.10.244.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747472206; bh=sgN03rBnm/XPR1ads9Vu8J316F1lCpLgW/CCcjcMT/c=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=oKWoLrX2ocXlFSayrx0OdtZnvKQ7n/ZwyoTIvUjXq6iidh4hzwANDOBIqCDMXkElb43SuVYNw20h5coqTWUY6FCLp2nVRcV2GFj/RE3cyK6TBoRYujp2QP2pUEC6PgE2ky6xJ0vB81KjQ4y0iinJBjjNCRIiPOnrdQMfI0qulxbtmiWUM1dPsgsDu8c7wHSI1I30vljlF5Nzt8wc6XetMFh1iLXei8lFA2qFeV3kV5WC1+rRqxPIKVuPQ3sznzNaZ41ZzU38dpq5a3snPyHqIvpAfe/jLnbH1kIRG8mnwiGJHEFlxOejwdNn/dwwGqv1umVKJs72GveK4SXa0Yy3rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747472206; bh=HE/hVltzmwKVBw6XQ/7tQP3ilwSVUMslv4zwu6xMzmA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=C5nUerQkcb+lkChAA0XLJmSEMZ4GWRtbi1WJ/XVVxmlSPN+WeSGdYEDdbUzKPP+5PuDYYc+XDBPbqTPqLW0V3Xwmp9l5j585nYgDLhg6r9IUy8RkHKoNhicQeGcSZHopjn0CXje9Ga3rapb9TE2vY4lIfN/rr8gfNxbCUHXMdBDxYNKiiRuR6tn6CHAl+aCS46OGkmTiIqBAx/Y5WknXt/HI9W7/eSd0/mhxspMj1RrmGjcuH6ixWvJWaemp9iuM9COE5VOmClMdyS6BoyDw9W2Wep47VQVwI2PxkEqpR48RT2zGDcIdQt/fOuDmIfZcP39qjvjOlntpHoF+1glMIA==
X-YMail-OSG: XtFXwUcVM1k3U2bTwnUVTJkrW_3PdsNpB6lE3hOfeR0SnP2VOqu6G_PoYgU0UXZ
 jm4jbg4WXZpmUpHMnrBOSglm4RjGFp6GUqBZiEcWTUExeQlRaK6.TxGsx1DuN4tJ5W4n_Bn8u3ah
 ZaTvD1v3F_UUZs9SatYZj4nMAkxqhR8Zg5xYdI50eMCNUvMQnOfXVxGNpg6ZkNDhmHG5nrBi6oTl
 .if.V3pU28RUGbCJl.OAoeyVwWA9zspoiMBJ8hDSYahIhiaCgKf0XWjFHIQmovsAyz3rpe80YPVc
 tFL1UWg9Ab92SLX63IgLqF5YxgnbeUbPhpXEmAC0MZRSlj9Kz1gLRBql2SzdrrsaYRjvR0b3h77A
 8Y1PKT2e.HyYOaGvLdI_YwzFpmvWU4BtGj93CXEirGi4mLf.v0dBhUUWIROMWIC7VMe2Bf8vZiKr
 .DcuaciHpbLwWc5vBw3CVuhwEuaVRoBeYEJ2sDk1cg_xn7ihjA3qXOXCmZfOnDAwJIir6PAvrABA
 ZwecgS5plzwaZkwXfXR8gpbj33u1kH8F_iThpet_JMDZ.GH3rn4cbhN2ryUN8pqXETIKeG2anOPO
 SEj9fa3ikl9IL8BDSOG53LAV981s2m7f91zIm3jlwcQCCpa97UjQ5w6HctWPzm3B8ui8ReYdMek0
 9Vjf27IxH7EiLSvDoP_n9ADQ1.oVSTCz5pVFmvBSHEG5LU1Htf7l7dyDW.EbsY5WIlS_Am4CqP1W
 GS5AkwUh7M1Ag5NeS.CV2V34G1pjMuiIomRJOSIiCvvjtjlrhru.U5iV8G2mZYY35WranwdXFDSV
 x1_APHcJAArdpbyoOCPao4_OJytEKwvhtOEGgCzVhBaWKdFQvG7hiyiL2qJbCm9iF9y8obCSKMOq
 ErYpRyCUcCyn5SVlaePYBbBAmT1k.nZlJQ2r2rDBvj8HB5ZzdjDEMARfwjaLN_rvnfK1myJva45R
 nt6h2LdPksYfS8Z3uxeGuY7QwbxOdHYqfKMT4t6udiEm0lirssutPYuHm0fzxOBpVZ0Ds0e6n0oM
 YFnXdkeAZA0Kqf.XpBrWwvf9Ad89bMeySQ2PBHvwhvhtzqFit7TIuj5CtISHlwTApG1e.bniR7R3
 1Jh9ueDP10mYYURlQxkUiNhoFXMyt5IiVpdkVNrUNG2qAT8Od9iYmUBKrhQZMN92R2GSsQQ1EPND
 ykVqQt5Xd8lSNONQd_J64kvo3sBWf5DQmZ8LtJ1ogNe8jej1R3JVfSr3AfC2L1kWPRG93iZz_os7
 4wtUCKdvmB5xSr4Ofk1_BXCVumVrX71BumfGWEY0AOQZnl2gQ2lzLbJozORUbqAKVeMnIXFSbtwd
 awtbsLaE4GTGKoqpay.JPKQbdIE5tzUMTBTjtotg0WItrQk_2ca7jFWi1pPEjq.TDCp5csD1xSN2
 paQ4vnfVv2tD2qYLJDdTY384QRtEg4IL5k0UG7xey41mSi62HY8nmMMgb1ON_srGXzNWzPfi0oPi
 pMMOwsK5B97NxyRqrPYbZcPK46XeP7bi3hMxct3cazXwNSLBRq.ivrmHTCvudJFFNv00GgbIRz6f
 PV8lsFRr5tGmcKgTDQT.j9UPomwLxEzNURiMDmqK7IjVgMjgydsDYYv0fM2xBeOP3Ox2PnNsjiBN
 Z08Ieg9yb2lqnRC3quGPA_xPdcI26TBDT1_l7GHZ5Uv1JfzPl5qw8g4oedCuAL9kVJuZE06SLPly
 w852JgeedzDaHx0in_WWrLM8.txWp3mGcj9dBF97OfWGG_MRYsNTjIeFsbsVqHMxm_TZKNr95UFG
 zU1cTBcaYtT.c.zLGpaet5cp9quJPSql5bWNGGJ_swMVza2CWaliD5bU5ZVd1U8raEJK0Psr5Ke8
 CHK7zKTFgo9MD.hcqL_6BjmO3fLplVZK7u9LOLFe7v_cDec7Qz.3Cu3lqmjdL27QO.hvTZC2VF_Y
 Rh9GPDJBUCerkNF9gApWDeuntEgog..pZ6.aH7nVQC0CW6yTbJXnixKVZZ_c9.UydjDTQ21ApQ8P
 _qn3NXgmABoh65GpqXmnWn32inM3s5zXozlzpaqDnUhyOSrSKKXlygPy5vEcRJn0a5JaLUNGZs3V
 .bSyiTcm4HYW79.O7.NME1P9eyWF7ccw42Slv4g9Q7dZy_01.kQ0bB.uDzP9u5iBYZ4NjoSCrCaf
 CATtGg_nKcffNYHSa_sg7VMyoWT5lIquEaFsEnBfKh6QBkU0rmDLUPbSah2aKYL8W1D7EUyjUI2D
 5JTFbVLg-
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: cea3403a-0bc8-4ce3-9e17-7af250094bb7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Sat, 17 May 2025 08:56:46 +0000
Received: by hermes--production-gq1-74d64bb7d7-k2g2q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7db3f94345a434ae8c2469c6376a7ff;
          Sat, 17 May 2025 08:26:20 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: skhan@linuxfoundation.org,
	jdelvare@suse.com,
	wsa+renesas@sang-engineering.com
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: i2c: Fix "resitors" to "resistors"
Date: Sat, 17 May 2025 01:25:27 -0700
Message-ID: <20250517082555.1249609-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250517082555.1249609-1-sumanth.gavini.ref@yahoo.com>

Fix misspelling reported by codespell

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 Documentation/i2c/busses/i2c-parport.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/busses/i2c-parport.rst b/Documentation/i2c/busses/i2c-parport.rst
index a9b4e8133700..4cbf45952d52 100644
--- a/Documentation/i2c/busses/i2c-parport.rst
+++ b/Documentation/i2c/busses/i2c-parport.rst
@@ -84,7 +84,7 @@ Remarks:
                    \|
 
    must be 74HC05, they must be open collector output.
- - All resitors are 10k.
+ - All resistors are 10k.
  - Pins 18-25 of the parallel port connected to GND.
  - Pins 4-9 (D2-D7) could be used as VDD is the driver drives them high.
    The ADM1032 evaluation board uses D4-D7. Beware that the amount of
-- 
2.43.0


