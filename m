Return-Path: <linux-kernel+bounces-841208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3B1BB680E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287E3484688
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC12EB5B4;
	Fri,  3 Oct 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzNH+hoB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8339ACF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489061; cv=none; b=OCvJjnAJ5Ml1VMTryezZ2dKzyxlci3x9unO6aeqCtE1E4KCu/Un0jS/evl1WzBU0uR77CcNNzQJ2hIM2GamlQpNC2304gKYTO8gmcZmKA13noW6DYWLGqF83FtJ2csdqXHkGOP7HTiDmDUevWfJAEOJ6lUY/xOW0BzSzN1LQpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489061; c=relaxed/simple;
	bh=rDsisar/vYgR0nEa1CjXdibGYgfr3Orwsw6CMhWJWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da6GyhXjVbwWcKfnNh+TbOUiq4XGXJPf0fKwMqNwL3hS11JnVnb3kT50dhh2OiTk+jF6l1I95+Si41NSKkglHaO9aGTG+hNZ+DoGOr6O1qwDYN+24lpEYKANle5CtWb4TBkrNconw6qp4C4xG+2VK1j/1c5uF2htmwRpS0l8H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzNH+hoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B7EC4CEF5;
	Fri,  3 Oct 2025 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759489059;
	bh=rDsisar/vYgR0nEa1CjXdibGYgfr3Orwsw6CMhWJWJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzNH+hoBKXlgqXqV5h879YvS8RJLuUSecYMjYPykeRmmcXyiy54f2Sf1+cSPVRPbg
	 2s/1oVtluS/1q5o0gmNqjDaAz8FSElFBRimmCDMODmyPX00fdV2W3XRJ6t/Rw95cFK
	 Ji/19gfkQg7Q6GG09Ct3yb4UinBIynF8RFJluvg5EBcpwuboUcrVROfz0xHmS2REgq
	 3oKUuvDRGbnJB0c2IKXs2la+hAahpoH3oP953R2fkhWZtm9sD3fQUIVrDq/PfOddOx
	 wQM1eTod31KjJEf9GR5l13l3uh58WzvQNpGgVlNxIHcJnyKUT4wcoQFyIbpfjrfXao
	 0P0lT5lQhlJkw==
Date: Fri, 3 Oct 2025 11:57:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in
 hugetlb_vmdelete_list
Message-ID: <7a1d0eb0-ab08-4fa8-bdab-b193b69a8c9d@sirena.org.uk>
References: <20250926033255.10930-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="67sMmfEQjBtt4ZBF"
Content-Disposition: inline
In-Reply-To: <20250926033255.10930-1-kartikey406@gmail.com>
X-Cookie: Save the Whales -- Harpoon a Honda.


--67sMmfEQjBtt4ZBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2025 at 09:02:54AM +0530, Deepanshu Kartikey wrote:
> hugetlb_vmdelete_list() uses trylock to acquire VMA locks during truncate
> operations. As per the original design in commit 40549ba8f8e0 ("hugetlb:
> use new vma_lock for pmd sharing synchronization"), if the trylock fails
> or the VMA has no lock, it should skip that VMA. Any remaining mapped
> pages are handled by remove_inode_hugepages() which is called after
> hugetlb_vmdelete_list() and uses proper lock ordering to guarantee
> unmapping success.

For the past few days I've been seeing failures on Raspberry Pi 4 in
the hugetlbfs-madvise kselftest in -next which bisect to this patch.
The test reports:

# # -------------------------
# # running ./hugetlb-madvise
# # -------------------------
# # Unexpected number of free huge pages line 252
# # [FAIL]
# not ok 6 hugetlb-madvise # exit=1

Full log:

  https://lava.sirena.org.uk/scheduler/job/1913276#L1803

Bisect log:

# bad: [7396732143a22b42bb97710173d598aaf50daa89] Add linux-next specific files for 20251002
# good: [9d3bc72cc0a9791bf4910ef854b2c3dd61af3bbf] Merge branch 'for-rc' of https://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git
# good: [d4ecae56a8c7d3287a5bcdb2d65f7102ee580ab6] clk: mediatek: Add MT8196 mcu clock support
# good: [4c134c2a5f3db29afe35b2d30e39bb6d867b08da] um: Indent time-travel help messages
# good: [bf1af4f6e62878e053d20cd71267aed8dfb3e715] perf arm-spe: Downsample all sample types equally
# good: [e414334883f4835058ca06f934bc4988eb9cd9e6] Merge branch 'next/dt' into for-next
# good: [54653bb3ec83d1f717adab6108db82a3966d19ee] clk: renesas: rzv2h: remove round_rate() in favor of determine_rate()
# good: [87a877de367d835b527d1086f75727123ef85fc4] KVM: x86: Rename handle_fastpath_set_msr_irqoff() to handle_fastpath_wrmsr()
# good: [c26675447faff8c4ddc1dc5d2cd28326b8181aaf] KVM: x86: Zero XSTATE components on INIT by iterating over supported features
# good: [6684aba0780da9f505c202f27e68ee6d18c0aa66] XArray: Add extra debugging check to xas_lock and friends
git bisect start '7396732143a22b42bb97710173d598aaf50daa89' '9d3bc72cc0a9791bf4910ef854b2c3dd61af3bbf' 'd4ecae56a8c7d3287a5bcdb2d65f7102ee580ab6' '4c134c2a5f3db29afe35b2d30e39bb6d867b08da' 'bf1af4f6e62878e053d20cd71267aed8dfb3e715' 'e414334883f4835058ca06f934bc4988eb9cd9e6' '54653bb3ec83d1f717adab6108db82a3966d19ee' '87a877de367d835b527d1086f75727123ef85fc4' 'c26675447faff8c4ddc1dc5d2cd28326b8181aaf' '6684aba0780da9f505c202f27e68ee6d18c0aa66'
# test job: [d4ecae56a8c7d3287a5bcdb2d65f7102ee580ab6] https://lava.sirena.org.uk/scheduler/job/1907306
# test job: [4c134c2a5f3db29afe35b2d30e39bb6d867b08da] https://lava.sirena.org.uk/scheduler/job/1903298
# test job: [bf1af4f6e62878e053d20cd71267aed8dfb3e715] https://lava.sirena.org.uk/scheduler/job/1900552
# test job: [e414334883f4835058ca06f934bc4988eb9cd9e6] https://lava.sirena.org.uk/scheduler/job/1904803
# test job: [54653bb3ec83d1f717adab6108db82a3966d19ee] https://lava.sirena.org.uk/scheduler/job/1900685
# test job: [87a877de367d835b527d1086f75727123ef85fc4] https://lava.sirena.org.uk/scheduler/job/1697972
# test job: [c26675447faff8c4ddc1dc5d2cd28326b8181aaf] https://lava.sirena.org.uk/scheduler/job/1698132
# test job: [6684aba0780da9f505c202f27e68ee6d18c0aa66] https://lava.sirena.org.uk/scheduler/job/1738722
# test job: [7396732143a22b42bb97710173d598aaf50daa89] https://lava.sirena.org.uk/scheduler/job/1913276
# bad: [7396732143a22b42bb97710173d598aaf50daa89] Add linux-next specific files for 20251002
git bisect bad 7396732143a22b42bb97710173d598aaf50daa89
# test job: [74fc450198cf792e3db35ea4d49197a467233373] https://lava.sirena.org.uk/scheduler/job/1913848
# bad: [74fc450198cf792e3db35ea4d49197a467233373] Merge branch 'main' of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 74fc450198cf792e3db35ea4d49197a467233373
# test job: [db484ff3fff1fafa0017cdd017795bec09ace5e4] https://lava.sirena.org.uk/scheduler/job/1913993
# bad: [db484ff3fff1fafa0017cdd017795bec09ace5e4] Merge branch 'docs-next' of git://git.lwn.net/linux.git
git bisect bad db484ff3fff1fafa0017cdd017795bec09ace5e4
# test job: [7d942c9d9660e6808dcd835c4c73ad5405cc5518] https://lava.sirena.org.uk/scheduler/job/1914055
# bad: [7d942c9d9660e6808dcd835c4c73ad5405cc5518] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
git bisect bad 7d942c9d9660e6808dcd835c4c73ad5405cc5518
# test job: [db03d3c83bdb21667392d1596fafdfb38325c2a0] https://lava.sirena.org.uk/scheduler/job/1914176
# bad: [db03d3c83bdb21667392d1596fafdfb38325c2a0] Merge branch 'dma-mapping-for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git
git bisect bad db03d3c83bdb21667392d1596fafdfb38325c2a0
# test job: [84a7a9823e73fe3c0adcc4780fa7a091981048ef] https://lava.sirena.org.uk/scheduler/job/1914247
# good: [84a7a9823e73fe3c0adcc4780fa7a091981048ef] mm/shmem, swap: remove redundant error handling for replacing folio
git bisect good 84a7a9823e73fe3c0adcc4780fa7a091981048ef
# test job: [c7416f37e4d31fb28ac4ed584b13037e69a22dbe] https://lava.sirena.org.uk/scheduler/job/1914387
# bad: [c7416f37e4d31fb28ac4ed584b13037e69a22dbe] Merge branch 'mm-nonmm-stable' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad c7416f37e4d31fb28ac4ed584b13037e69a22dbe
# test job: [3dfd02c900379d209ac9dcac24b4a61d8478842a] https://lava.sirena.org.uk/scheduler/job/1914497
# good: [3dfd02c900379d209ac9dcac24b4a61d8478842a] hugetlb: increase number of reserving hugepages via cmdline
git bisect good 3dfd02c900379d209ac9dcac24b4a61d8478842a
# test job: [fe7a283b39160153b6d1bd7f61b0a9d5d44987a8] https://lava.sirena.org.uk/scheduler/job/1915206
# good: [fe7a283b39160153b6d1bd7f61b0a9d5d44987a8] ocfs2: add suballoc slot check in ocfs2_validate_inode_block()
git bisect good fe7a283b39160153b6d1bd7f61b0a9d5d44987a8
# test job: [74058c0a9fc8b2b4d5f4a0ef7ee2cfa66a9e49cf] https://lava.sirena.org.uk/scheduler/job/1916011
# good: [74058c0a9fc8b2b4d5f4a0ef7ee2cfa66a9e49cf] Squashfs: fix uninit-value in squashfs_get_parent
git bisect good 74058c0a9fc8b2b4d5f4a0ef7ee2cfa66a9e49cf
# test job: [9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b] https://lava.sirena.org.uk/scheduler/job/1916064
# good: [9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b] Squashfs: reject negative file sizes in squashfs_read_inode()
git bisect good 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b
# test job: [fb552b2425cf8f16c9c72229a972d1744b24d855] https://lava.sirena.org.uk/scheduler/job/1916102
# good: [fb552b2425cf8f16c9c72229a972d1744b24d855] alloc_tag: fix boot failure due to NULL pointer dereference
git bisect good fb552b2425cf8f16c9c72229a972d1744b24d855
# test job: [81e78b7ec61e89e8bab9736551839f79b063614c] https://lava.sirena.org.uk/scheduler/job/1916193
# bad: [81e78b7ec61e89e8bab9736551839f79b063614c] mm: convert folio_page() back to a macro
git bisect bad 81e78b7ec61e89e8bab9736551839f79b063614c
# test job: [1acc369373008b9eeb930fbb47847c0693055553] https://lava.sirena.org.uk/scheduler/job/1916218
# bad: [1acc369373008b9eeb930fbb47847c0693055553] mm/khugepaged: use start_addr/addr for improved readability
git bisect bad 1acc369373008b9eeb930fbb47847c0693055553
# test job: [dd83609b88986f4add37c0871c3434310652ebd5] https://lava.sirena.org.uk/scheduler/job/1916225
# bad: [dd83609b88986f4add37c0871c3434310652ebd5] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
git bisect bad dd83609b88986f4add37c0871c3434310652ebd5
# first bad commit: [dd83609b88986f4add37c0871c3434310652ebd5] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list

--67sMmfEQjBtt4ZBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjfrB4ACgkQJNaLcl1U
h9DAAgf/dem2WT55fAIeHx5L3Ugexl4ofWcegpn4HsI55fzE/1iBMaA/UKbCzLgi
hCBpEFtNxWel4h+iBjtDsYOh/V2R6a0YiqGlG2QJc0RaJOhJyJeZwMAlJAkbVqqp
fnfzr9GJw7MsnfNfQ2UxHmDnEIUH7sWJ49z/nXKkp6qLef/dvjNsvKRk/Q4x6PI0
IdWWOpaQlgMvHcal/TVbBxtiC5UqoaSXUg2JzxkjADAKrfCAV2C49JmLmlOL3iP+
zfDAyf0kQ/8BNbcPsnWVkOwXfatw/sVbl7sL8JCma2rsmp8z9bBOSuGpWvEGBJIp
95LhrPm8x9sMzjQryrWPRR/zsk6irQ==
=SKjz
-----END PGP SIGNATURE-----

--67sMmfEQjBtt4ZBF--

