Return-Path: <linux-kernel+bounces-892540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA51C4550D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C86C1346892
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6802EB873;
	Mon, 10 Nov 2025 08:07:50 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575222FE11
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762070; cv=none; b=jQInjIQLRMKt46zQmw1Oj7vcNR9nzxBSYk7g5p7gZg8VognNyRWIyusRgwVUjYCQOe6ZD8UhF3C63VFwcuL3Q01c1PUtGIqHZB7HxeGayAZTeEeN5+MswKP299CYGzLYY+EvwvEfduvONi/FRUcEkC8d+nme0z1p/LdrnHVpubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762070; c=relaxed/simple;
	bh=XE9rNfbtCppOOc0ESV6MaPT1yxtFjl74Aj5Fvi0xTWk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qh3SXHFzpCDQBj5PmARCd2ayQ2yVFt/UYcslS3CtmqJY1r1WSz9agJHv7I0j1x1L6VRm1mpimdAc+hgOGNTne/ITbJBJ/Xqyy4t5XPHhRSxf6ZmekAH/VNtaV2HKD1DCbg1ctiq7d3aYjgoqXlxrIAMZENc3B8QfamAdVfvCAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz11t1762762011t8ad1da07
X-QQ-Originating-IP: jebWHaXc8UD+0OL/OQ3Y8YwrWHEn+o3ibGGGhb14+uU=
Received: from smtpclient.apple ( [125.120.180.10])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Nov 2025 16:06:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1781396948337886877
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:225:undefined
 reference to `phylink_ethtool_nway_reset'
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <202511101227.KAE47Twi-lkp@intel.com>
Date: Mon, 10 Nov 2025 16:06:39 +0800
Cc: oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C57250E-E666-4AE0-8B88-25DB073B005B@net-swift.com>
References: <202511101227.KAE47Twi-lkp@intel.com>
To: kuba@kernel.org
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NehG/3ADkt1fzPl4nbBHnDAaSJ4T/wnSPI3SmxoVMcqmaSl46z+t4v/t
	FiCvkPLsgSAoVLcBc7lnF6gvk83q7n6iI7eR6IEwpoPu7jKMAaBiaLoBJ5t/vXQSwsHdHm5
	AqgrHuHiZQw6ydou//qWfEwwwNsuVQqwt2tgpgPK4lQAJh603GcCTmRiqWq0895x0vYBzxN
	EA1qr5sAqRlbZi8c4PNHNAQXxd7C21oRl6yd25XRo+Y2rVG4wJHjCoaIqoztLntTq+wqRrh
	o2kk1jxo5obU3XmbP52WOndbmWglTMABBfQExhyMLy6mzn0gzLVpPPifSt6jG5jhNiEoXul
	hGoqVmcauOChVcDe0uJ4i9TXiUZL9hw7hgq7Ot3wxixhT0DqODw36Esz9tpO0b/MAiz6CA+
	20ivfklHc9tJt9ETMXaXGIUX4xNXX2WUT2CY4XddAXWQi+lKd9HKEHslebn8+F4kCp1HJWI
	fAfFt87NYsPsDS2lRbveoK/0kC/GifTBmyrTt7XJZDS7IVzEnxlKn6m1ccLK862BLp5jqSF
	nJsj+ktScvpUv9YgKmMM79AxRiRcRtb68kQPDrGAvlrsz/MiePEOK3v4YaXXFoIiMem9nji
	pluXWF0B7k9f7tvptSHnc6X8fKJOAQg4kydjBsiOD07qJhQIWpxjbY8SmO2wNot2rBErV5w
	Ltdhlzt5s6zPqkbh3+sOHLnyHjk6m4YvMgswlIK92SPnTMLbQBUyRJzHz1NQuh9NQXGCJiI
	/e9c6iMzJUNepcr3yEejK0ln4+h4DP5wvNCFBQ7aanzFwP6OY0dWDonYn1OXQoaN2filU87
	vqM8apC3KIzB+Cf2hWj/gI72HmX83UTf2nzzA+B7LFiNqeG4DCUIH0kVAosqonP/1wDnrM0
	tQx28DkEgr9+D6yTT5NW7J6c6Yds/Q3hMdMVH0RV5cmN0Q3631aq43EzurOYgy6S+zf6Vj/
	2mEuN0GIBFMZ9yB3TMeF4HL3IfFrRFYOwfB7G7g/iSo7mDlZU8UYstQFMx2sikG7FTSa1JW
	KfvlWoDfSLFw9jaUdfz2SpgwS5/moaQPPYcBWB9L3WLuSU5KmD
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi,

 A fix patch has already been submitted.

Commit id : a86eb2a60dcc2e23d86d24272d474f0ddecc824e
=
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit=
/drivers/net/ethernet/wangxun?id=3Da86eb2a60dcc2e23d86d24272d474f0ddecc824=
e


> 2025=E5=B9=B411=E6=9C=8810=E6=97=A5 12:12=EF=BC=8Ckernel test robot =
<lkp@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
> head:   e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
> commit: a0008a3658a34a54e77f2568bdaa2626233b1459 net: wangxun: add =
ngbevf build
> date:   4 months ago
> config: x86_64-randconfig-072-20251110 =
(https://download.01.org/0day-ci/archive/20251110/202511101227.KAE47Twi-lk=
p@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> reproduce (this is a W=3D1 build): =
(https://download.01.org/0day-ci/archive/20251110/202511101227.KAE47Twi-lk=
p@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: =
https://lore.kernel.org/oe-kbuild-all/202511101227.KAE47Twi-lkp@intel.com/=

>=20
> All errors (new ones prefixed by >>):
>=20
>   ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function =
`wx_nway_reset':
>>> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:225:(.text+0x1ea0): =
undefined reference to `phylink_ethtool_nway_reset'
>   ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function =
`wx_get_link_ksettings':
>>> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:234:(.text+0x1ef7): =
undefined reference to `phylink_ethtool_ksettings_get'
>   ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function =
`wx_set_link_ksettings':
>>> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:246:(.text+0x1f74): =
undefined reference to `phylink_ethtool_ksettings_set'
>   ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function =
`wx_set_pauseparam':
>>> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:270:(.text+0x2014): =
undefined reference to `phylink_ethtool_set_pauseparam'
>   ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function =
`wx_get_pauseparam':
>>> drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:258:(.text+0x27a4): =
undefined reference to `phylink_ethtool_get_pauseparam'
>=20
>=20
> vim +225 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
>=20
> e8e138cf7383cf Jiawen Wu 2024-01-03  217 =20
> e8e138cf7383cf Jiawen Wu 2024-01-03  218  int wx_nway_reset(struct =
net_device *netdev)
> e8e138cf7383cf Jiawen Wu 2024-01-03  219  {
> e8e138cf7383cf Jiawen Wu 2024-01-03  220   struct wx *wx =3D =
netdev_priv(netdev);
> e8e138cf7383cf Jiawen Wu 2024-01-03  221 =20
> 39709fe4bacda6 Jiawen Wu 2025-05-21  222   if (wx->mac.type =3D=3D =
wx_mac_aml40)
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  223   return -EOPNOTSUPP;
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  224 =20
> e8e138cf7383cf Jiawen Wu 2024-01-03 @225   return =
phylink_ethtool_nway_reset(wx->phylink);
> e8e138cf7383cf Jiawen Wu 2024-01-03  226  }
> e8e138cf7383cf Jiawen Wu 2024-01-03  227  =
EXPORT_SYMBOL(wx_nway_reset);
> e8e138cf7383cf Jiawen Wu 2024-01-03  228 =20
> e8e138cf7383cf Jiawen Wu 2024-01-03  229  int =
wx_get_link_ksettings(struct net_device *netdev,
> e8e138cf7383cf Jiawen Wu 2024-01-03  230    struct =
ethtool_link_ksettings *cmd)
> e8e138cf7383cf Jiawen Wu 2024-01-03  231  {
> e8e138cf7383cf Jiawen Wu 2024-01-03  232   struct wx *wx =3D =
netdev_priv(netdev);
> e8e138cf7383cf Jiawen Wu 2024-01-03  233 =20
> e8e138cf7383cf Jiawen Wu 2024-01-03 @234   return =
phylink_ethtool_ksettings_get(wx->phylink, cmd);
> e8e138cf7383cf Jiawen Wu 2024-01-03  235  }
> e8e138cf7383cf Jiawen Wu 2024-01-03  236  =
EXPORT_SYMBOL(wx_get_link_ksettings);
> e8e138cf7383cf Jiawen Wu 2024-01-03  237 =20
> e8e138cf7383cf Jiawen Wu 2024-01-03  238  int =
wx_set_link_ksettings(struct net_device *netdev,
> e8e138cf7383cf Jiawen Wu 2024-01-03  239    const struct =
ethtool_link_ksettings *cmd)
> e8e138cf7383cf Jiawen Wu 2024-01-03  240  {
> e8e138cf7383cf Jiawen Wu 2024-01-03  241   struct wx *wx =3D =
netdev_priv(netdev);
> e8e138cf7383cf Jiawen Wu 2024-01-03  242 =20
> 39709fe4bacda6 Jiawen Wu 2025-05-21  243   if (wx->mac.type =3D=3D =
wx_mac_aml40)
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  244   return -EOPNOTSUPP;
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  245 =20
> e8e138cf7383cf Jiawen Wu 2024-01-03 @246   return =
phylink_ethtool_ksettings_set(wx->phylink, cmd);
> e8e138cf7383cf Jiawen Wu 2024-01-03  247  }
> e8e138cf7383cf Jiawen Wu 2024-01-03  248  =
EXPORT_SYMBOL(wx_set_link_ksettings);
> 2fe2ca09da953b Jiawen Wu 2024-01-03  249 =20
> 2fe2ca09da953b Jiawen Wu 2024-01-03  250  void =
wx_get_pauseparam(struct net_device *netdev,
> 2fe2ca09da953b Jiawen Wu 2024-01-03  251         struct =
ethtool_pauseparam *pause)
> 2fe2ca09da953b Jiawen Wu 2024-01-03  252  {
> 2fe2ca09da953b Jiawen Wu 2024-01-03  253   struct wx *wx =3D =
netdev_priv(netdev);
> 2fe2ca09da953b Jiawen Wu 2024-01-03  254 =20
> 39709fe4bacda6 Jiawen Wu 2025-05-21  255   if (wx->mac.type =3D=3D =
wx_mac_aml40)
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  256   return;
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  257 =20
> 2fe2ca09da953b Jiawen Wu 2024-01-03 @258   =
phylink_ethtool_get_pauseparam(wx->phylink, pause);
> 2fe2ca09da953b Jiawen Wu 2024-01-03  259  }
> 2fe2ca09da953b Jiawen Wu 2024-01-03  260  =
EXPORT_SYMBOL(wx_get_pauseparam);
> 2fe2ca09da953b Jiawen Wu 2024-01-03  261 =20
> 2fe2ca09da953b Jiawen Wu 2024-01-03  262  int wx_set_pauseparam(struct =
net_device *netdev,
> 2fe2ca09da953b Jiawen Wu 2024-01-03  263        struct =
ethtool_pauseparam *pause)
> 2fe2ca09da953b Jiawen Wu 2024-01-03  264  {
> 2fe2ca09da953b Jiawen Wu 2024-01-03  265   struct wx *wx =3D =
netdev_priv(netdev);
> 2fe2ca09da953b Jiawen Wu 2024-01-03  266 =20
> 39709fe4bacda6 Jiawen Wu 2025-05-21  267   if (wx->mac.type =3D=3D =
wx_mac_aml40)
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  268   return -EOPNOTSUPP;
> 2e5af6b2ae8532 Jiawen Wu 2025-02-21  269 =20
> 2fe2ca09da953b Jiawen Wu 2024-01-03 @270   return =
phylink_ethtool_set_pauseparam(wx->phylink, pause);
> 2fe2ca09da953b Jiawen Wu 2024-01-03  271  }
> 2fe2ca09da953b Jiawen Wu 2024-01-03  272  =
EXPORT_SYMBOL(wx_set_pauseparam);
> 883b5984a5d290 Jiawen Wu 2024-01-03  273 =20
>=20
> :::::: The code at line 225 was first introduced by commit
> :::::: e8e138cf7383cf820419fcbec63992e75a01467b net: libwx: add =
phylink to libwx
>=20
> :::::: TO: Jiawen Wu <jiawenwu@trustnetic.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20


