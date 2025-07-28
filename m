Return-Path: <linux-kernel+bounces-748251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8EB13E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52876168E07
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BB272811;
	Mon, 28 Jul 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnRyA2wt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC539270557;
	Mon, 28 Jul 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716792; cv=none; b=fY2guuv0g3pA3JCWkjadltk/2TOcklXqnz8mkTJfbusxxuBrHsVWe4G8+Z+9Szuo+v4BVbW+Oy0aMAvNuWLmQJpnDsRjKfitDFQnY65mnZhtyBnxWSMPv7tz/XkZAR4snlMyP/4BAlvczx8ARmcC66JfMmzNffU57X4K7FxqYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716792; c=relaxed/simple;
	bh=rmQ5Dpw7q70m/bVWkQP+hcMEHhICjmYLdatn19PTQ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6IZ3co1UupEcwdDzAJsi4zALvtXtB3PmErsa9qp5w0a4g1Q4d+hGYTagGJPm4O/KUt7MPM+qRuRqcHQUoyfKxhbtkWZndcVgJL8+H3iDLioklhiC1ZLhO9ihE9RztK9jdZkJo7lmrl3TD97QzsrWzFCdIFSkgfeiaLtiaHdyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnRyA2wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72029C4CEE7;
	Mon, 28 Jul 2025 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753716791;
	bh=rmQ5Dpw7q70m/bVWkQP+hcMEHhICjmYLdatn19PTQ/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DnRyA2wtst7FjybA3WjyxHI22SvQoXzZiI86OVKatHrIt7Olm5fnPZjRE4opCIAqw
	 zUgZalyUSlTjwpP+H2/zLcQ/RsPdG3MIvpdO5ilFzoMWIIZbxMeL4UlQD/Eg38ZwU6
	 rxBp7tOE2o6FtxmSgeqpec1esN9AfeLJKUa7PfPG3t5Mk+Tm4/lAV416R3lU1bYvGq
	 vqfPcqSR1UdYFuREWbDxPyCcsTqoceGOvCfOmbeHyodSak5v4noX4I3dA4LlE1mPIs
	 0hXJxqKOMAsp62MG6nyDGhn25MB6GhzrSbyUnJlS2rfeyb84AMTxKeia1/4Ez+Zv/J
	 cloEW07gK0iFw==
Date: Mon, 28 Jul 2025 17:33:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
Message-ID: <20250728173306.2ab1409a@sal.lan>
In-Reply-To: <83d12d5293e23c622ae390204fed8fd4453014b1@intel.com>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
	<58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
	<20250712163155.GA22640@pendragon.ideasonboard.com>
	<20250713002517.7f52b0e9@foz.lan>
	<875xfhabv0.fsf@trenco.lwn.net>
	<20250724194306.27b98194@foz.lan>
	<83d12d5293e23c622ae390204fed8fd4453014b1@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Mon, 28 Jul 2025 12:28:45 +0300
Jani Nikula <jani.nikula@intel.com> escreveu:

> On Thu, 24 Jul 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wr=
ote:
> > Em Thu, 24 Jul 2025 08:42:59 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >>=20
> >> > Maybe I can place instead CONFIG_DRM_I915_WERROR.
> >>=20
> >> I've held off on this series on the expectation that a new version wou=
ld
> >> come.  I guess, at this point, it will be a post-merge-window thing?
> >
> > Feel free to postpone. I have already a new version of it here somewher=
e on
> > my branches, but I had to take some days off. So, I ended not sending y=
ou
> > the (probably) final version.
> >
> > I intend to send what I have here during the merge window for you to
> > review and apply post-merge-window.
>=20
> I think the main questions here are 1) how to handle optional build tool
> dependencies, and 2) whether Python is an optional or required
> dependency.

with regards to (2), besides doc build and kernel-doc --none, there is
at least another place at the building system requiring Python:=20
scripts/Makefile.vmlinux_o: There, it has:

	quiet_cmd_gen_initcalls_lds =3D GEN     $@
	      cmd_gen_initcalls_lds =3D \
	        $(PYTHON3) $(srctree)/scripts/jobserver-exec \
	        $(PERL) $(real-prereqs) > $@

	.tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
	                vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
	        $(call if_changed,gen_initcalls_lds)

	targets :=3D .tmp_initcalls.lds

	ifdef CONFIG_LTO_CLANG
	initcalls-lds :=3D .tmp_initcalls.lds
	endif

Now, I didn't check exactly what conditions trigger
.tmp_initcalls.lds, but there are some places that use
select:

	arch/Kconfig:   select LTO_CLANG

On a quick look, it sounds that some archs will select this
automatically when built with clang.

I didn't check if other parts of the building system requires it.

In any case, on its current state, I'd say that currently this
is not optional.

> It might be nice to be able to have an actual Kconfig and dependency for
> optional tools. "depends on TOOL_PYTHON" or something. Enable the
> option, and you should have Python.

That would be an option. The question is: is it worth spending
time on it?

> This in turn raises the question for allyesconfig. It's cumbersome
> (though not impossible) to add config options that you actually have to
> enable manually.

IMO it doesn't make sense to manually enable something with *config.
If they depend on Python, be it: for such targets, Python is
mandatory.

>=20
> The header test stuff really isn't required to actually build the kernel
> or drm, however DRM_MSM does depend on Python for building the driver.

Good to know. It means that, for those *config targets:

	arch/arm/configs/imx_v6_v7_defconfig:CONFIG_DRM_MSM=3Dy
	arch/arm/configs/multi_v7_defconfig:CONFIG_DRM_MSM=3Dm
	arch/arm/configs/qcom_defconfig:CONFIG_DRM_MSM=3Dm

(plus all{mod|yes}config)

Python is mandatory. As multi_v7_defconfig is one of them, we
may assume, that, o practical cases, Python 2.7 or 3.2+ is=20
mandatory for arm support. The current requirement is:

	$ vermin -v --no-tips ./drivers/gpu/drm/msm/registers/gen_header.py
	Detecting python files..
	Analyzing using 8 processes..
	2.7, 3.2     /new_devel/v4l/docs/drivers/gpu/drm/msm/registers/gen_header.=
py
	Minimum required versions: 2.7, 3.2

Heh, looking for files that end with .py at Makefile (not all
Python scripts at the Kernel end with such extension), it seems
that there are more:

	grep \\\.py $(git ls-files|grep Makefile|grep -v tools)


	Makefile:KERNELDOC       =3D $(srctree)/scripts/kernel-doc.py
	Makefile:		  vmlinux-gdb.py \
	Makefile:	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
	Makefile:compile_commands.json: $(srctree)/scripts/clang-tools/gen_compile=
_commands.py \
	Makefile:      cmd_clang_tools =3D $(PYTHON3) $(srctree)/scripts/clang-too=
ls/run-clang-tools.py $@ $<
	drivers/gpu/drm/msm/Makefile:      cmd_headergen =3D mkdir -p $(obj)/gener=
ated && $(PYTHON3) $(src)/registers/gen_header.py \
	drivers/gpu/drm/msm/Makefile:		$(src)/registers/gen_header.py \
	drivers/gpu/drm/msm/Makefile:		$(src)/registers/gen_header.py \
	drivers/tty/vt/Makefile:#GENERATE_UCS_TABLES :=3D 2  # invokes gen_ucs_rec=
ompose_table.py with --full
	drivers/tty/vt/Makefile:$(obj)/ucs_width_table.h: $(src)/gen_ucs_width_tab=
le.py
	drivers/tty/vt/Makefile:$(obj)/ucs_recompose_table.h: $(src)/gen_ucs_recom=
pose_table.py
	drivers/tty/vt/Makefile:$(obj)/ucs_fallback_table.h: $(src)/gen_ucs_fallba=
ck_table.py
	rust/Makefile:	$(Q)MAKEFLAGS=3D $(srctree)/scripts/generate_rust_analyzer.=
py \
	scripts/Makefile.lib:MAKE_FIT :=3D $(srctree)/scripts/make_fit.py
	scripts/gdb/linux/Makefile:symlinks :=3D $(patsubst $(src)/%,%,$(wildcard =
$(src)/*.py))
	scripts/gdb/linux/Makefile:always-y +=3D constants.py
	scripts/gdb/linux/Makefile:$(obj)/constants.py: $(src)/constants.py.in FOR=
CE
	scripts/gdb/linux/Makefile:clean-files :=3D *.pyc *.pyo

(that not including tools/*)

Some seem false positives, but on the other hand, looking for tools,
several scripts seem to be executed by non-tools Makefiles. I didn't
check if any of them are written in python, though.

Considering the above, for me it seems that the bus already=20
departed: there are several cases where Python is required during
build time. So, adding a "depends on TOOL_PYTHON" doesn't seem
to be trivial.

=46rom my side, I don't mind much about that, as this is something
that affects only the Kernel build. I would very much prefer to
have things like config BPF optional.

Regards,
Mauro


