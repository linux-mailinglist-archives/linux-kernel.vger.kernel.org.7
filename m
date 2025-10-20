Return-Path: <linux-kernel+bounces-861471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1E5BF2CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B30C04E2F45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0432F764;
	Mon, 20 Oct 2025 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPO/bmMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F62E9EDD
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982737; cv=none; b=OHuOFgZ2H/V9ZWqwW4/QaAe1O3Via06amcICceJAN+O/T5y6hIcQ39SZ3/dMoEgr2Br2aYMpUnPj8z1kIr6XQVK5EgFjHi+HJNh0zcl8RiQYSRlcOnioew43ICtvDA0Cv1pTcP8HtAWv3ONH2mLqqc/y34yn339owtB0Z/Qz3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982737; c=relaxed/simple;
	bh=7sAIIgLxZTkRmg9+IStAmoK1ltS9LtxTlQvl1Ut6g5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbXahbBoQ6aDz/lJrDkhciuLXHbXUC9xd5DbkQF4yZt8QBAkfs0vp/g/6jpWRFfHP8j0i1Jc5d9w+qhV7CkT09QZjJsFSqjl6ZwmT23cuoEx0MVEsbk21Cyt1Hz/mEOZPyDVPtNjC90n/fm6MRdrfKLEVu+2H+8S5vxstFeUBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPO/bmMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B53C4CEF9;
	Mon, 20 Oct 2025 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982736;
	bh=7sAIIgLxZTkRmg9+IStAmoK1ltS9LtxTlQvl1Ut6g5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPO/bmMkvowEEjMVkjqssDByXDYAFYwrSHASHiROoswJCme1T7kXpmeJLmKi7NlKh
	 ltUaUJzXwbAvGVc6OZtYiE6m83Gx7MSzBnmrv33GvuqOEFPm9LIHiAciLyc3P3fqNw
	 ojuatUpJG6OhAERH3v8nt4Ar2Q154I1KyLa6Il2RHm1sIpmrL5aKOC7sDuKyOPgIRp
	 Kpp7ze/lQwiK9B5rHYPWPCrI4xOheBOBzQ/m298DUeIq7RBVirU3lEegmpFlWHArhv
	 8MOD3XurI8OSg0E74+J4pERamsVY18saN9tkuHlFuqI4928PQ2te1s1Hxfl1mZ35Mf
	 rggDikZeZnFeQ==
Date: Mon, 20 Oct 2025 18:52:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com,
	Aishwarya.TCV@arm.com, torvalds@linux-foundation.org
Subject: Re: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in
 hugetlb_vmdelete_list
Message-ID: <9d20e689-c06e-43f8-811f-3e66f3e86d2b@sirena.org.uk>
References: <20250926033255.10930-1-kartikey406@gmail.com>
 <7a1d0eb0-ab08-4fa8-bdab-b193b69a8c9d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yyTuGu9lnDO8eP9m"
Content-Disposition: inline
In-Reply-To: <7a1d0eb0-ab08-4fa8-bdab-b193b69a8c9d@sirena.org.uk>
X-Cookie: Sic Transit Gloria Thursdi.


--yyTuGu9lnDO8eP9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 11:57:35AM +0100, Mark Brown wrote:
> On Fri, Sep 26, 2025 at 09:02:54AM +0530, Deepanshu Kartikey wrote:
> > hugetlb_vmdelete_list() uses trylock to acquire VMA locks during trunca=
te
> > operations. As per the original design in commit 40549ba8f8e0 ("hugetlb:
> > use new vma_lock for pmd sharing synchronization"), if the trylock fails
> > or the VMA has no lock, it should skip that VMA. Any remaining mapped
> > pages are handled by remove_inode_hugepages() which is called after
> > hugetlb_vmdelete_list() and uses proper lock ordering to guarantee
> > unmapping success.
>=20
> For the past few days I've been seeing failures on Raspberry Pi 4 in
> the hugetlbfs-madvise kselftest in -next which bisect to this patch.
> The test reports:
>=20
> # # -------------------------
> # # running ./hugetlb-madvise
> # # -------------------------
> # # Unexpected number of free huge pages line 252
> # # [FAIL]
> # not ok 6 hugetlb-madvise # exit=3D1

This issue is now present in mainline:

Raspberry Pi 4: https://lava.sirena.org.uk/scheduler/job/1976561#L1798
Orion O6:       https://lava.sirena.org.uk/scheduler/job/1977081#L1779

and still bisects to this patch.

> Full log:
>=20
>   https://lava.sirena.org.uk/scheduler/job/1913276#L1803
>=20
> Bisect log:
>=20
> # bad: [7396732143a22b42bb97710173d598aaf50daa89] Add linux-next specific=
 files for 20251002
> # good: [9d3bc72cc0a9791bf4910ef854b2c3dd61af3bbf] Merge branch 'for-rc' =
of https://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git
> # good: [d4ecae56a8c7d3287a5bcdb2d65f7102ee580ab6] clk: mediatek: Add MT8=
196 mcu clock support
> # good: [4c134c2a5f3db29afe35b2d30e39bb6d867b08da] um: Indent time-travel=
 help messages
> # good: [bf1af4f6e62878e053d20cd71267aed8dfb3e715] perf arm-spe: Downsamp=
le all sample types equally
> # good: [e414334883f4835058ca06f934bc4988eb9cd9e6] Merge branch 'next/dt'=
 into for-next
> # good: [54653bb3ec83d1f717adab6108db82a3966d19ee] clk: renesas: rzv2h: r=
emove round_rate() in favor of determine_rate()
> # good: [87a877de367d835b527d1086f75727123ef85fc4] KVM: x86: Rename handl=
e_fastpath_set_msr_irqoff() to handle_fastpath_wrmsr()
> # good: [c26675447faff8c4ddc1dc5d2cd28326b8181aaf] KVM: x86: Zero XSTATE =
components on INIT by iterating over supported features
> # good: [6684aba0780da9f505c202f27e68ee6d18c0aa66] XArray: Add extra debu=
gging check to xas_lock and friends
> git bisect start '7396732143a22b42bb97710173d598aaf50daa89' '9d3bc72cc0a9=
791bf4910ef854b2c3dd61af3bbf' 'd4ecae56a8c7d3287a5bcdb2d65f7102ee580ab6' '4=
c134c2a5f3db29afe35b2d30e39bb6d867b08da' 'bf1af4f6e62878e053d20cd71267aed8d=
fb3e715' 'e414334883f4835058ca06f934bc4988eb9cd9e6' '54653bb3ec83d1f717adab=
6108db82a3966d19ee' '87a877de367d835b527d1086f75727123ef85fc4' 'c26675447fa=
ff8c4ddc1dc5d2cd28326b8181aaf' '6684aba0780da9f505c202f27e68ee6d18c0aa66'
> # test job: [d4ecae56a8c7d3287a5bcdb2d65f7102ee580ab6] https://lava.siren=
a.org.uk/scheduler/job/1907306
> # test job: [4c134c2a5f3db29afe35b2d30e39bb6d867b08da] https://lava.siren=
a.org.uk/scheduler/job/1903298
> # test job: [bf1af4f6e62878e053d20cd71267aed8dfb3e715] https://lava.siren=
a.org.uk/scheduler/job/1900552
> # test job: [e414334883f4835058ca06f934bc4988eb9cd9e6] https://lava.siren=
a.org.uk/scheduler/job/1904803
> # test job: [54653bb3ec83d1f717adab6108db82a3966d19ee] https://lava.siren=
a.org.uk/scheduler/job/1900685
> # test job: [87a877de367d835b527d1086f75727123ef85fc4] https://lava.siren=
a.org.uk/scheduler/job/1697972
> # test job: [c26675447faff8c4ddc1dc5d2cd28326b8181aaf] https://lava.siren=
a.org.uk/scheduler/job/1698132
> # test job: [6684aba0780da9f505c202f27e68ee6d18c0aa66] https://lava.siren=
a.org.uk/scheduler/job/1738722
> # test job: [7396732143a22b42bb97710173d598aaf50daa89] https://lava.siren=
a.org.uk/scheduler/job/1913276
> # bad: [7396732143a22b42bb97710173d598aaf50daa89] Add linux-next specific=
 files for 20251002
> git bisect bad 7396732143a22b42bb97710173d598aaf50daa89
> # test job: [74fc450198cf792e3db35ea4d49197a467233373] https://lava.siren=
a.org.uk/scheduler/job/1913848
> # bad: [74fc450198cf792e3db35ea4d49197a467233373] Merge branch 'main' of =
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect bad 74fc450198cf792e3db35ea4d49197a467233373
> # test job: [db484ff3fff1fafa0017cdd017795bec09ace5e4] https://lava.siren=
a.org.uk/scheduler/job/1913993
> # bad: [db484ff3fff1fafa0017cdd017795bec09ace5e4] Merge branch 'docs-next=
' of git://git.lwn.net/linux.git
> git bisect bad db484ff3fff1fafa0017cdd017795bec09ace5e4
> # test job: [7d942c9d9660e6808dcd835c4c73ad5405cc5518] https://lava.siren=
a.org.uk/scheduler/job/1914055
> # bad: [7d942c9d9660e6808dcd835c4c73ad5405cc5518] Merge branch 'for-next'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
> git bisect bad 7d942c9d9660e6808dcd835c4c73ad5405cc5518
> # test job: [db03d3c83bdb21667392d1596fafdfb38325c2a0] https://lava.siren=
a.org.uk/scheduler/job/1914176
> # bad: [db03d3c83bdb21667392d1596fafdfb38325c2a0] Merge branch 'dma-mappi=
ng-for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski=
/linux.git
> git bisect bad db03d3c83bdb21667392d1596fafdfb38325c2a0
> # test job: [84a7a9823e73fe3c0adcc4780fa7a091981048ef] https://lava.siren=
a.org.uk/scheduler/job/1914247
> # good: [84a7a9823e73fe3c0adcc4780fa7a091981048ef] mm/shmem, swap: remove=
 redundant error handling for replacing folio
> git bisect good 84a7a9823e73fe3c0adcc4780fa7a091981048ef
> # test job: [c7416f37e4d31fb28ac4ed584b13037e69a22dbe] https://lava.siren=
a.org.uk/scheduler/job/1914387
> # bad: [c7416f37e4d31fb28ac4ed584b13037e69a22dbe] Merge branch 'mm-nonmm-=
stable' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad c7416f37e4d31fb28ac4ed584b13037e69a22dbe
> # test job: [3dfd02c900379d209ac9dcac24b4a61d8478842a] https://lava.siren=
a.org.uk/scheduler/job/1914497
> # good: [3dfd02c900379d209ac9dcac24b4a61d8478842a] hugetlb: increase numb=
er of reserving hugepages via cmdline
> git bisect good 3dfd02c900379d209ac9dcac24b4a61d8478842a
> # test job: [fe7a283b39160153b6d1bd7f61b0a9d5d44987a8] https://lava.siren=
a.org.uk/scheduler/job/1915206
> # good: [fe7a283b39160153b6d1bd7f61b0a9d5d44987a8] ocfs2: add suballoc sl=
ot check in ocfs2_validate_inode_block()
> git bisect good fe7a283b39160153b6d1bd7f61b0a9d5d44987a8
> # test job: [74058c0a9fc8b2b4d5f4a0ef7ee2cfa66a9e49cf] https://lava.siren=
a.org.uk/scheduler/job/1916011
> # good: [74058c0a9fc8b2b4d5f4a0ef7ee2cfa66a9e49cf] Squashfs: fix uninit-v=
alue in squashfs_get_parent
> git bisect good 74058c0a9fc8b2b4d5f4a0ef7ee2cfa66a9e49cf
> # test job: [9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b] https://lava.siren=
a.org.uk/scheduler/job/1916064
> # good: [9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b] Squashfs: reject negat=
ive file sizes in squashfs_read_inode()
> git bisect good 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b
> # test job: [fb552b2425cf8f16c9c72229a972d1744b24d855] https://lava.siren=
a.org.uk/scheduler/job/1916102
> # good: [fb552b2425cf8f16c9c72229a972d1744b24d855] alloc_tag: fix boot fa=
ilure due to NULL pointer dereference
> git bisect good fb552b2425cf8f16c9c72229a972d1744b24d855
> # test job: [81e78b7ec61e89e8bab9736551839f79b063614c] https://lava.siren=
a.org.uk/scheduler/job/1916193
> # bad: [81e78b7ec61e89e8bab9736551839f79b063614c] mm: convert folio_page(=
) back to a macro
> git bisect bad 81e78b7ec61e89e8bab9736551839f79b063614c
> # test job: [1acc369373008b9eeb930fbb47847c0693055553] https://lava.siren=
a.org.uk/scheduler/job/1916218
> # bad: [1acc369373008b9eeb930fbb47847c0693055553] mm/khugepaged: use star=
t_addr/addr for improved readability
> git bisect bad 1acc369373008b9eeb930fbb47847c0693055553
> # test job: [dd83609b88986f4add37c0871c3434310652ebd5] https://lava.siren=
a.org.uk/scheduler/job/1916225
> # bad: [dd83609b88986f4add37c0871c3434310652ebd5] hugetlbfs: skip VMAs wi=
thout shareable locks in hugetlb_vmdelete_list
> git bisect bad dd83609b88986f4add37c0871c3434310652ebd5
> # first bad commit: [dd83609b88986f4add37c0871c3434310652ebd5] hugetlbfs:=
 skip VMAs without shareable locks in hugetlb_vmdelete_list



--yyTuGu9lnDO8eP9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj2dsoACgkQJNaLcl1U
h9Da2gf/T6/QZw+cK8/E1zTR2oE9jdXkFHM6mwGxdCEEE4m6IacU3MOB4a3f3hGA
GMSlCEApk/POPMnwFikM0kRCRgOA0nkbz/iYEaz6kk+bxvZW7OWJ2ka2JPSG1UuG
ifZ+xnyiqkJY/4/E0mgrlL32YBBbtEDPKxUKH9TAv004AbvUQWGrVprlEO76hlzy
rH+nqp1WOrM7qUgTWPmUNE1d0iobuUOj8Wc6tF1zJawETwyjXNw263P/av9La9xS
xAZx71YX0E0kuu8QS8KJBPMafEjsiqGauRZB7X+tS37mCRnzbrKAhIzykzQ2ceCI
7JG0Fyetx+uWH5LH5rrnDblgrxze9A==
=RoL8
-----END PGP SIGNATURE-----

--yyTuGu9lnDO8eP9m--

