Return-Path: <linux-kernel+bounces-743872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F823B104EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B04E6942
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CA827BF80;
	Thu, 24 Jul 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S7sFuc+w"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE3274B4D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346557; cv=none; b=hUO1hZHsL1Y9OZv6T+1dpJt82fZKvaCNpjLCfzTveRWJChcCXTR7BU0Jmvn7TMK+LPmsl2AdUbtTKlRDWZ3FisBosBLW4e4WUeAgoiLpyxnC7aQ4VaQr39C1eiLSKrJFcyK1bqXpCdelA1BmXneujMggPTphgnL1Qa8hFLBqNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346557; c=relaxed/simple;
	bh=4ov1H0hzj8aJ62VVlU7FnHVBA9C0gzXGbPZYySiNC9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tGz0Ac4oNs7Co72xtkOvwqqIhMr+WzfZkcEpGSxufNUvz4HbOZqX15yioGCgyfBNKIYgPoFl5XsBh8HjSzZ1mrCX6dOpg2IOiznUVmJeVc7iM0LNXUhU+npi59zgbCQzsloqAiGX0NQUMgymjOzS9ED4XegxGfG85kBMy2OubyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S7sFuc+w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56O8gUSa9169289, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753346550; bh=i+9FHegRog5uPaRC+MlJ7wHIrI2XZgOhzCa5s5b1IM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=S7sFuc+wtiGE8zT/Avxlxe6/P3/30riEiYeHcdhPwXOsA1wt/rxuWUa+EsueQXuii
	 ZhR4OeBGtAYkurl1sicYIHdFcM5WUvktyWmXaTvwoVKwa/grX5JlDxB3+o50Qrm3st
	 gy0/GtPXbR6IJWBgmuhngHHtXjxvuKDYKSNl0T/mtTnb3UxbE5BdbAgkq5Hijpgq8v
	 Xxs6G1Yo+q5Foeja9ozOvJFLa+mi+6SRlz4KCUfD1u/2k0sP64DeK9TPCvENpmWetr
	 OJXRbMoM9c4siioopYJsNhABWOJ/juPQCm7B6KxDOuBnmFt5PzSsCnhy6FHKlvxIUk
	 Ha2KW9L9AbMwQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56O8gUSa9169289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:42:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 16:42:30 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Jul 2025 16:42:29 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::8461:d6ec:c854:f9f4]) by
 RTEXMBS03.realtek.com.tw ([fe80::8461:d6ec:c854:f9f4%2]) with mapi id
 15.01.2507.035; Thu, 24 Jul 2025 16:42:29 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Mande Imran Ahmed <immu.ahmed1905@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        Bernie Huang <phhuang@realtek.com>,
        Damon Chen <damon.chen@realtek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net:realtek:use sysfs_emit() instead of scnprintf() for sysfs consistency
Thread-Topic: [PATCH] net:realtek:use sysfs_emit() instead of scnprintf() for
 sysfs consistency
Thread-Index: AQHb/F77uipCH/1W9kat5J+TgxiIm7RA7abg
Date: Thu, 24 Jul 2025 08:42:29 +0000
Message-ID: <a28456f5b8d2477785493c6081f24401@realtek.com>
References: <20250724055018.15878-1-immu.ahmed1905@gmail.com>
In-Reply-To: <20250724055018.15878-1-immu.ahmed1905@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Mande Imran Ahmed <immu.ahmed1905@gmail.com> wrote:
>=20
> Update the Realtek rtw89 wireless driver to replace scnprintf() with
> sysfs_emit() for formatting sysfs attribute output, in line with the reco=
mmendations from
> Documentation/filesystems/sysfs.rst.
>=20
> This change enhances the safety and correctness of sysfs handling, promot=
es consistency
> throughout the kernel, and aids long-term maintainability.
>=20
> Functionality verified using ping, iperf, and connection tests to ensure =
stability after the
> change.
>=20
> Signed-off-by: Mande Imran Ahmed <immu.ahmed1905@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw89/phy.c |  8 +++----
> drivers/net/wireless/realtek/rtw89/sar.c | 30 ++++++++++++------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c
> b/drivers/net/wireless/realtek/rtw89/phy.c
> index 76a2e26d4a10..a58aefb51fb5 100644
> --- a/drivers/net/wireless/realtek/rtw89/phy.c
> +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> @@ -2087,19 +2087,19 @@ EXPORT_SYMBOL(rtw89_phy_ant_gain_pwr_offset);
>  int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t buf=
sz,
>                          const struct rtw89_chan *chan)  {
> -       char *p =3D buf, *end =3D buf + bufsz;
> +       char *p =3D buf;
>         s8 offset_patha, offset_pathb;
>=20
>         if (!rtw89_can_apply_ant_gain(rtwdev, chan->band_type)) {
> -               p +=3D scnprintf(p, end - p, "no DAG is applied\n");
> +               p +=3D sysfs_emit(p, "no DAG is applied\n");
>                 goto out;
>         }
>=20
>         offset_patha =3D rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan=
->freq);
>         offset_pathb =3D rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, chan=
->freq);
>=20
> -       p +=3D scnprintf(p, end - p, "ChainA offset: %d dBm\n", offset_pa=
tha);
> -       p +=3D scnprintf(p, end - p, "ChainB offset: %d dBm\n", offset_pa=
thb);
> +       p +=3D sysfs_emit(p, "ChainA offset: %d dBm\n", offset_patha);
> +       p +=3D sysfs_emit(p, "ChainB offset: %d dBm\n", offset_pathb);
>=20
>  out:
>         return p - buf;
> diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wirel=
ess/realtek/rtw89/sar.c
> index 517b66022f18..80eacada6911 100644
> --- a/drivers/net/wireless/realtek/rtw89/sar.c
> +++ b/drivers/net/wireless/realtek/rtw89/sar.c
> @@ -318,7 +318,7 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *b=
uf, size_t bufsz,
>         /* its members are protected by rtw89_sar_set_src() */
>         const struct rtw89_sar_handler *sar_hdl =3D &rtw89_sar_handlers[s=
rc];
>         const u8 fct_mac =3D rtwdev->chip->txpwr_factor_mac;
> -       char *p =3D buf, *end =3D buf + bufsz;
> +       char *p =3D buf;
>         int ret;
>         s32 cfg;
>         u8 fct;
> @@ -326,17 +326,17 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char =
*buf, size_t
> bufsz,
>         lockdep_assert_wiphy(rtwdev->hw->wiphy);
>=20
>         if (src =3D=3D RTW89_SAR_SOURCE_NONE) {
> -               p +=3D scnprintf(p, end - p, "no SAR is applied\n");
> +               p +=3D sysfs_emit(p, "no SAR is applied\n");
>                 goto out;
>         }
>=20
> -       p +=3D scnprintf(p, end - p, "source: %d (%s)\n", src,
> +       p +=3D sysfs_emit(p, "source: %d (%s)\n", src,
>                        sar_hdl->descr_sar_source);
>=20
>         ret =3D sar_hdl->query_sar_config(rtwdev, sar_parm, &cfg);
>         if (ret) {
> -               p +=3D scnprintf(p, end - p, "config: return code: %d\n",=
 ret);
> -               p +=3D scnprintf(p, end - p,
> +               p +=3D sysfs_emit(p, "config: return code: %d\n", ret);
> +               p +=3D sysfs_emit(p,
>                                "assign: max setting: %d (unit: 1/%lu dBm)=
\n",
>                                RTW89_SAR_TXPWR_MAC_MAX, BIT(fct_mac));
>                 goto out;
> @@ -344,10 +344,10 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char =
*buf, size_t
> bufsz,
>=20
>         fct =3D sar_hdl->txpwr_factor_sar;
>=20
> -       p +=3D scnprintf(p, end - p, "config: %d (unit: 1/%lu dBm)\n", cf=
g,
> +       p +=3D sysfs_emit(p, "config: %d (unit: 1/%lu dBm)\n", cfg,
>                        BIT(fct));
>=20
> -       p +=3D scnprintf(p, end - p, "support different configs by antenn=
a: %s\n",
> +       p +=3D sysfs_emit(p, "support different configs by antenna: %s\n"=
,
>                        str_yes_no(rtwdev->chip->support_sar_by_ant));
>  out:
>         return p - buf;
> @@ -356,24 +356,24 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char =
*buf, size_t
> bufsz,  int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t b=
ufsz)  {
>         struct rtw89_tas_info *tas =3D &rtwdev->tas;
> -       char *p =3D buf, *end =3D buf + bufsz;
> +       char *p =3D buf;
>=20
>         if (!rtw89_tas_is_active(rtwdev)) {
> -               p +=3D scnprintf(p, end - p, "no TAS is applied\n");
> +               p +=3D sysfs_emit(p, "no TAS is applied\n");
>                 goto out;
>         }
>=20
> -       p +=3D scnprintf(p, end - p, "State: %s\n",
> +       p +=3D sysfs_emit(p, "State: %s\n",
>                        rtw89_tas_state_str(tas->state));
> -       p +=3D scnprintf(p, end - p, "Average time: %d\n",
> +       p +=3D sysfs_emit(p, "Average time: %d\n",
>                        tas->window_size * 2);
> -       p +=3D scnprintf(p, end - p, "SAR gap: %d dBm\n",
> +       p +=3D sysfs_emit(p, "SAR gap: %d dBm\n",
>                        RTW89_TAS_SAR_GAP >> RTW89_TAS_FACTOR);
> -       p +=3D scnprintf(p, end - p, "DPR gap: %d dBm\n",
> +       p +=3D sysfs_emit(p, "DPR gap: %d dBm\n",
>                        RTW89_TAS_DPR_GAP >> RTW89_TAS_FACTOR);
> -       p +=3D scnprintf(p, end - p, "DPR ON offset: %d dBm\n",
> +       p +=3D sysfs_emit(p, "DPR ON offset: %d dBm\n",
>                        RTW89_TAS_DPR_ON_OFFSET >> RTW89_TAS_FACTOR);
> -       p +=3D scnprintf(p, end - p, "DPR OFF offset: %d dBm\n",
> +       p +=3D sysfs_emit(p, "DPR OFF offset: %d dBm\n",
>                        RTW89_TAS_DPR_OFF_OFFSET >> RTW89_TAS_FACTOR);
>=20
>  out:
> --
> 2.43.0

(1.) buffer might not just be allocated with PAGE_SIZE
(2.) the pointer passed to leaf function might not point to the head of all=
ocated buffer

Will the above cause some problems ?

For (2.), maybe need to tweak them with sysfs_emit_at() instead of sysfs_em=
it(). !?

