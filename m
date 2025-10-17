Return-Path: <linux-kernel+bounces-857601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F24BE738B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FD719A7D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262E2BD016;
	Fri, 17 Oct 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA8Ptb1j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311F25F984
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690576; cv=none; b=kEQIrvfzdlLu7Dx0bWiNuq06MMvfYqzwToer6oZrHsRwFpeqS3165xsNicn9tz8bKWQoc5OGZolY3DmXufmWKzVbj8lYlmSiv8J8NrYCj7tWhuH0L3W+bFP+OjNHQuZ8zPDo2x8K1T/R73FyxArwQN/FnJRYxXQVifC+gVCfKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690576; c=relaxed/simple;
	bh=qSUMFR75goMMtDYJDGq5W9aDIq4ECJWmBjA175zM9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReUCm4L1IfUHDwTYxq+Lr+JTHKxrp7sUv08qVoQl4OdVLCGT4d2Sh8imVYfaofalT3yjcO7cynjyhnHQzmWi1GnVOmRk6iWXJGTExtMAVoO/1bRWms4sIf2hCbq+u2hZrBZFMFr4K6GMqzRUgMTzB7V+pDSGWTIMMNJIUYduj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA8Ptb1j; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760690575; x=1792226575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qSUMFR75goMMtDYJDGq5W9aDIq4ECJWmBjA175zM9x4=;
  b=EA8Ptb1jrGm/ECrd6OEuE9z9n19a0/ygZ0Yyn75Vv6sNAlFQY0WSiAmZ
   B9goo5m0d0J0GiITkRCulZLusa+wjCUUjB/43gIJiSw9pl/1BbZtUIJiA
   yX5d28QBP9/tD3qr6TK5T3BIcvsxtBIu/oleJvC2GYP2Qt5tEBgmOUvQv
   xi8wVBC7JH8remLC2ltMJho/vp1ubwVRsGugzUZxc9lE1WlOwfQCxBzek
   cc9KOKw4rzEyxqFCraTWKP7bZ/pQNK1lYoTfBO0WcppPhjVHMTnY1pMcz
   o0clkTg8hGgpru50z2InjWqbr1rmlpMDWmCxLO9FELj7RYB7Ve7B8AJ3W
   g==;
X-CSE-ConnectionGUID: EQCiCmjcQkWdLZ/UnT3ZDA==
X-CSE-MsgGUID: I/YWYrsJT+2pXHMC6Aa+kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62806790"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62806790"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 01:42:55 -0700
X-CSE-ConnectionGUID: 7FOmOAIrSb+0xDJtrJMAFA==
X-CSE-MsgGUID: qNbZHmYLSTuQM9x//DHQzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="183088248"
Received: from vtg-chrome.bj.intel.com ([172.16.116.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Oct 2025 01:42:52 -0700
From: bingbu.cao@intel.com
To: linux-firmware@kernel.org
Cc: linux-kernel@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	hao.yao@intel.com
Subject: [PATCH] Intel IPU7: Update product signed firmware binary
Date: Fri, 17 Oct 2025 16:42:49 +0800
Message-Id: <20251017084249.2796351-2-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017084249.2796351-1-bingbu.cao@intel.com>
References: <20251017084249.2796351-1-bingbu.cao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bingbu Cao <bingbu.cao@intel.com>

Update IPU7 firmware binary, it is a product signed binary
used in latest Intel Pather Lake SOCs. Its version is same
as the old one, but it's product signed binary which can
be used in released product.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 WHENCE                   |   2 +-
 intel/ipu/ipu7ptl_fw.bin | Bin 266240 -> 266240 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index c95b791e4477..9ff1918f5f9c 100644
--- a/WHENCE
+++ b/WHENCE
@@ -1398,7 +1398,7 @@ File: intel/ipu/ipu7_fw.bin
 Version: master_release_20240628_1854
 
 File: intel/ipu/ipu7ptl_fw.bin
-Version: master_release_20250515_1232
+Version: master_release_20250515_1232_ProductSigned
 
 Licence: Redistributable. See LICENSE.intel for details
 
diff --git a/intel/ipu/ipu7ptl_fw.bin b/intel/ipu/ipu7ptl_fw.bin
index 32526904344e1df4108d8184c375fe23f9fca092..491f61e64e9d779da3fdb1733c03405eec074a17 100644
GIT binary patch
delta 809
zcmV+^1J?Y2pb&td5U|Vve@FV_NZ;44qovZ{PgO|bxO7A6Xa%9b>&v5TL4cN{8;EHE
zEn@&W%B41|b;S8t7K#?kR)fT0Cwm9dB4XhRYdg~QwA|{e@5TFi^U~tz2GadLGNF4t
z?A9}ct~ftJx**?I?u|=`?y(>{AY=x;N^<;(v#imW5SW(rIe2%af4GkT-xTX0i107x
z)pZcnVV;4H*Ek4?%_kL9yA_R8+I8LmY@~36w)gO#^2WqkG(1dX?o`^ecOSab<=~mC
z%~&-yX5(_Yy~m7l4N{I&SIQur*CrW<oJYM;0OU8AlmN1Q@35jmUrovqHPr-R;jfrx
zjW1V(k^DH_B~_h>f9R?_t|^;Wa`1ncnH;t@0jpA+_dQj48oj0|=i7IRV?i1B@srs`
z@q7QyiHiH99T_lT%rG;hU1m#KI2Gm3VfAOi9zfyNe;O4Clc#GAf0ycF8SQ5)CrHYb
zMDl__IwI&iqQjSFI`w_IQ_oy;y{kVdv=t(S8ZxCLEVQxlf9EsH0RRC2eND^A4Fb4K
zjMn5(GR+bCfG2&ntZEf&v1kZ>6r8t;?!2P}V*8F|a&+sgEO+eWp_>L~e!ah3q9(M^
z;6^9F;LW*o7vE9Aootrjpfny+^A4FJ1FooqiU?C`(LDE)*odT=q3o!AUnO#R7Q^X-
z7_gVPl`H1?f5B6a%l#nzRaYQq4|K36t-yD~CO!lp$sVUD!P^x<HFn#-i2|;CKBm`%
z;}v2pHVv4C_Nk_*4v-clkIZ6)=QDNF>9}uf%!$oR;pMNOoJm;!JeCQ+ILi^y=5A7C
zJO)8|mry-<5Q4Zjg`|{s>9=i@_r`CP+bPT)y-C)te|St|;&#$+a4GW;&n8vbR$<yI
z|3|z_*~!SI-31$?-U4X<urVxEM;KaL?yilPHVY@umd_~O!6jcBI|gA;88Z;6u4A!<
zxK^T;88db8wy$xG$~nG+@E<9PcK4P`?XiY+s}DtQ|Mhl82rc2G&}hyR5;X4&xNb`+
nBDa7h3Q`o?U${*P=`3J_&;*Cj1ObQ81OkW91OvCw1OzY(x;c?#

delta 809
zcmV+^1J?Y2pb&td5U|Vvf0;z$Mq&>fEp&7g@i=EZKFeW}+tk6YUmtP@+)-f;EkTIW
zEg#*>R+-WKI*IomAz9MYgiNc>(N6v~vZQI~jgKwW*_i8P2xVii(lAc)k>$p?DzFH_
zw=DOPY$-`Sa^6i;6mEct{zM!ZmQ%CVZi>%qe+Od@c&8h^y)DRLe^RYQW*v5q0ew~J
ziCZ0j@L(&v;$BU8ZAFc`GE;2>AkVJ2ZtZR;tR-_$C^2!-b+k24m;oz5&Yu{mE;O6N
z(@DfxQ;S9>&64-^K;Kqj^@(i-i20>2flWVAF!WkGY_|+{lzL-`<#zSBw^{h5%GsCi
zPv$u7kJ`Of(6q7}e<6Dhv@C(k0K*7z9DT`*6yDAhcYILAWtR3n#J}42uD4$z7<W9!
zZ{PUwjK%=-VVEudAiiu$KB@v3X`moOQC$jli>6Gt*AJS1Qyz*pV-m}@dU-T6aZzuz
z*;PmalL}w0DgqTUO@K?DMha_vw;2JLKttS5t)x!W<b}ohf3P*q0RRC2A(&CF`N5a+
z6Y2Hz$;iAc{lSFj?5{+GrO;qdM@->EiX_52L0z#g&#ylgoWIi<{__V9#rRS=K`>$N
zh4BkXe1#F{-H?FqO=H)u7*({#Hgq`5G@6=ap^{F2UdEnhoJmAJ?r#qt?wnr8h!+S_
zuCj>o7@b=ke?;&>(FM8iIagWo0EGNqgq#1(d|L-tdAP{ndv`AN{pj^+AXms7lj<AX
zeKhsX6!`dw1VZx!%oNG|71sJ+=)4<{elPInVga<8?N7h0Kh!>yVmtOw*Fxu5f^8(P
zz@ZGInZ6x;W+z38C&&A=S}JT{cIhK<H3{*EW|>)jf6neGnDNsPuU7@K+2LZ}Hw8<$
zir(b&kW$yZ^ceC#U?5=PC(!L#{V?D9u%vcucbB-naviWVi9~NKU2iMPTp+8hZnIst
zqD*Si!AT6v3Y&y@oQ`wlk_bW`a+Cdq+h2`wGa8Ukd>BSZ_e0a!5FgswmM6XdMprRw
n*7d`U3OPV=TZ`alWbP@0&;*Cj1ObQ81OkW91OvCw1OzY(NvDlu

-- 
2.34.1


