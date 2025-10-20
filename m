Return-Path: <linux-kernel+bounces-860835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F0BF11BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DD4B234B991
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A462FB615;
	Mon, 20 Oct 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF9rbAjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1902B9A8
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962625; cv=none; b=REab54B4hnafy55r8uakWECWCiJYOGuQbqlVopoOqRFEphXuBSVPmDfFCZg1Z6d5mxb+vqF36bpMMaxEGl2wFPVcsP97wmDPluH71w4zgDMnNrOvEtV5OYMxeGIptpbEQv05+BvWBeEF68nmXkIPrf9moApoSBQAWtUbBNO4O/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962625; c=relaxed/simple;
	bh=f18uF07cu2n+HT8STMn7t0hlJhmS++bLq0sHUrNFzZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzH3oxFIze/ByGDtuspQAnDedYYCZfRseYU9pOjeDpSp8/xCvgjcdpDFs1JVqVDMPk43gcKr+YOB5lRxLK3aadEF6t2I8gornnPgx04o8wAL1xsVBkaL+90jf0t8/LgJ9kJPLRrhHADnizqQpYbCN+s4Wni00DaM041GJcUq5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF9rbAjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DC1C113D0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760962624;
	bh=f18uF07cu2n+HT8STMn7t0hlJhmS++bLq0sHUrNFzZM=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=lF9rbAjESd8voKydj4p10txSxvUNs98oN3iri96YtNycp8rGwfEbrEHlmiCbyA60n
	 orkYaZ08h+5NZ0Q67HJUVXg0aIShjeixRt/9uGnSU1VsRdTVRykgLx6QhAheMSDSo0
	 E7xLEl2y8EbyDiMCDV2rXCyw5ItWvTlekuy2SIxxBmwnYhj4H723Hh/Z5DPNtuk48N
	 rMVb0M6QH4Cn0aIUO8IU5anoHdTzh24lLcby2ygENCXp6WBZYgdLj+eSAWUXaqujvP
	 wHVkbNIZ8NNcP0ZpF6n/C49MOtVyWd/CCl4JFWdNiDQkFggwk9pebVLYFei7Xw+6tm
	 BfNedCuzUzZmA==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-783fa3aa582so31267847b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:17:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCqtB94cR3dTd3PElTwL60QRbILc8yMT34C/aWqC1hw4mqdadwH/3EEGlrSBMLSKDGaz3XDO9q9GLA7xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgP7Xts25WY9rpSRnhrfGFhduKNEus1aQqjRSQJAq8NS2k0BQ
	tdW1jJDroKEsF6587Zg41QzjWzJ4hT/XmRuVxDtWr+TqF7F9ikfpIoAF8DdlGX11AjTuhiKBBWU
	SLkgWmgbvcHRh3mCBIy16RbN6uTwVVQc=
X-Google-Smtp-Source: AGHT+IEXxUVjWj0hn6ohZVnmilbB7NekiLS+ZJSbH+pYwA7T9ogOP6/y5Nrham5w/PU3b7VAVakpwyJ2KMVaKQ0jpNg=
X-Received: by 2002:a05:690e:168c:b0:63c:f5a7:3e7 with SMTP id
 956f58d0204a3-63e1620efedmr10405892d50.67.1760962623982; Mon, 20 Oct 2025
 05:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017084249.2796351-1-bingbu.cao@intel.com>
In-Reply-To: <20251017084249.2796351-1-bingbu.cao@intel.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 20 Oct 2025 08:16:52 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5VZOXjYhFfir2RfsVJXsRqmxwZxzivuWE8ZP0JvLLNrA@mail.gmail.com>
X-Gm-Features: AS18NWCRWDtFAdsQoiiROiiJYqljc3RTsmnlmteCrBfbkmlSJE_xvFqw_wW2WJM
Message-ID: <CA+5PVA5VZOXjYhFfir2RfsVJXsRqmxwZxzivuWE8ZP0JvLLNrA@mail.gmail.com>
Subject: Re: [PATCH] Intel IPU7: Update product signed firmware binary
To: bingbu.cao@intel.com
Cc: linux-firmware@kernel.org, linux-kernel@vger.kernel.org, 
	sakari.ailus@linux.intel.com, hao.yao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/744

josh

On Fri, Oct 17, 2025 at 4:42=E2=80=AFAM <bingbu.cao@intel.com> wrote:
>
> From: Bingbu Cao <bingbu.cao@intel.com>
>
> Update IPU7 firmware binary, it is a product signed binary
> used in latest Intel Pather Lake SOCs. Its version is same
> as the old one, but it's product signed binary which can
> be used in released product.
>
> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> ---
>  WHENCE                   |   2 +-
>  intel/ipu/ipu7ptl_fw.bin | Bin 266240 -> 266240 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/WHENCE b/WHENCE
> index c95b791e4477..9ff1918f5f9c 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -1398,7 +1398,7 @@ File: intel/ipu/ipu7_fw.bin
>  Version: master_release_20240628_1854
>
>  File: intel/ipu/ipu7ptl_fw.bin
> -Version: master_release_20250515_1232
> +Version: master_release_20250515_1232_ProductSigned
>
>  Licence: Redistributable. See LICENSE.intel for details
>
> diff --git a/intel/ipu/ipu7ptl_fw.bin b/intel/ipu/ipu7ptl_fw.bin
> index 32526904344e1df4108d8184c375fe23f9fca092..491f61e64e9d779da3fdb1733=
c03405eec074a17 100644
> GIT binary patch
> delta 809
> zcmV+^1J?Y2pb&td5U|Vve@FV_NZ;44qovZ{PgO|bxO7A6Xa%9b>&v5TL4cN{8;EHE
> zEn@&W%B41|b;S8t7K#?kR)fT0Cwm9dB4XhRYdg~QwA|{e@5TFi^U~tz2GadLGNF4t
> z?A9}ct~ftJx**?I?u|=3D`?y(>{AY=3Dx;N^<;(v#imW5SW(rIe2%af4GkT-xTX0i107x
> z)pZcnVV;4H*Ek4?%_kL9yA_R8+I8LmY@~36w)gO#^2WqkG(1dX?o`^ecOSab<=3D~mC
> z%~&-yX5(_Yy~m7l4N{I&SIQur*CrW<oJYM;0OU8AlmN1Q@35jmUrovqHPr-R;jfrx
> zjW1V(k^DH_B~_h>f9R?_t|^;Wa`1ncnH;t@0jpA+_dQj48oj0|=3Di7IRV?i1B@srs`
> z@q7QyiHiH99T_lT%rG;hU1m#KI2Gm3VfAOi9zfyNe;O4Clc#GAf0ycF8SQ5)CrHYb
> zMDl__IwI&iqQjSFI`w_IQ_oy;y{kVdv=3Dt(S8ZxCLEVQxlf9EsH0RRC2eND^A4Fb4K
> zjMn5(GR+bCfG2&ntZEf&v1kZ>6r8t;?!2P}V*8F|a&+sgEO+eWp_>L~e!ah3q9(M^
> z;6^9F;LW*o7vE9Aootrjpfny+^A4FJ1FooqiU?C`(LDE)*odT=3Dq3o!AUnO#R7Q^X-
> z7_gVPl`H1?f5B6a%l#nzRaYQq4|K36t-yD~CO!lp$sVUD!P^x<HFn#-i2|;CKBm`%
> z;}v2pHVv4C_Nk_*4v-clkIZ6)=3DQDNF>9}uf%!$oR;pMNOoJm;!JeCQ+ILi^y=3D5A7C
> zJO)8|mry-<5Q4Zjg`|{s>9=3Di@_r`CP+bPT)y-C)te|St|;&#$+a4GW;&n8vbR$<yI
> z|3|z_*~!SI-31$?-U4X<urVxEM;KaL?yilPHVY@umd_~O!6jcBI|gA;88Z;6u4A!<
> zxK^T;88db8wy$xG$~nG+@E<9PcK4P`?XiY+s}DtQ|Mhl82rc2G&}hyR5;X4&xNb`+
> nBDa7h3Q`o?U${*P=3D`3J_&;*Cj1ObQ81OkW91OvCw1OzY(x;c?#
>
> delta 809
> zcmV+^1J?Y2pb&td5U|Vvf0;z$Mq&>fEp&7g@i=3DEZKFeW}+tk6YUmtP@+)-f;EkTIW
> zEg#*>R+-WKI*IomAz9MYgiNc>(N6v~vZQI~jgKwW*_i8P2xVii(lAc)k>$p?DzFH_
> zw=3DDOPY$-`Sa^6i;6mEct{zM!ZmQ%CVZi>%qe+Od@c&8h^y)DRLe^RYQW*v5q0ew~J
> ziCZ0j@L(&v;$BU8ZAFc`GE;2>AkVJ2ZtZR;tR-_$C^2!-b+k24m;oz5&Yu{mE;O6N
> z(@DfxQ;S9>&64-^K;Kqj^@(i-i20>2flWVAF!WkGY_|+{lzL-`<#zSBw^{h5%GsCi
> zPv$u7kJ`Of(6q7}e<6Dhv@C(k0K*7z9DT`*6yDAhcYILAWtR3n#J}42uD4$z7<W9!
> zZ{PUwjK%=3D-VVEudAiiu$KB@v3X`moOQC$jli>6Gt*AJS1Qyz*pV-m}@dU-T6aZzuz
> z*;PmalL}w0DgqTUO@K?DMha_vw;2JLKttS5t)x!W<b}ohf3P*q0RRC2A(&CF`N5a+
> z6Y2Hz$;iAc{lSFj?5{+GrO;qdM@->EiX_52L0z#g&#ylgoWIi<{__V9#rRS=3DK`>$N
> zh4BkXe1#F{-H?FqO=3DH)u7*({#Hgq`5G@6=3Dap^{F2UdEnhoJmAJ?r#qt?wnr8h!+S_
> zuCj>o7@b=3Dke?;&>(FM8iIagWo0EGNqgq#1(d|L-tdAP{ndv`AN{pj^+AXms7lj<AX
> zeKhsX6!`dw1VZx!%oNG|71sJ+=3D)4<{elPInVga<8?N7h0Kh!>yVmtOw*Fxu5f^8(P
> zz@ZGInZ6x;W+z38C&&A=3DS}JT{cIhK<H3{*EW|>)jf6neGnDNsPuU7@K+2LZ}Hw8<$
> zir(b&kW$yZ^ceC#U?5=3DPC(!L#{V?D9u%vcucbB-naviWVi9~NKU2iMPTp+8hZnIst
> zqD*Si!AT6v3Y&y@oQ`wlk_bW`a+Cdq+h2`wGa8Ukd>BSZ_e0a!5FgswmM6XdMprRw
> n*7d`U3OPV=3DTZ`alWbP@0&;*Cj1ObQ81OkW91OvCw1OzY(NvDlu
>
> --
> 2.34.1
>

