Return-Path: <linux-kernel+bounces-773474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923FB2A0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80A252A73DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4AA2E2299;
	Mon, 18 Aug 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm4g2du4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B492E228D;
	Mon, 18 Aug 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516938; cv=none; b=cQZk2QoEDIjL3Ylh8kFAoaz5EIDSuVJt9vXneO8rxGPqKFuJRHjZc88oUlqwM17aFGcnaht0HQgXYd0VsPMX5d5O+72bSZO3bd2mjXp0eCMpxDAjwyMGFlt1r/pWD2SSB/gr/m3x7qpAJ5FXg9KmbG9+ULVaWwrz7l++aMWQ7GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516938; c=relaxed/simple;
	bh=yfZsEruc2SIJ9NNdIdJv3IchthpWf7/FEhASCOKz0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWTk16rFf3yI6G9L1pSzWKm5FgB8duGJBodtcyEix8UNqd+0WumO1kKbZrS4PgySSvjp3y3ArPAaXdw1HEkHFP0s/SQNlYXJXCmmJiS9GOar5mnuYJLXWZT2z5yzCRwpJ+qbLsKZ2fdr9J83TbqPHGou2y5BWL0fYJ2LBeNVff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm4g2du4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CD5C4CEEB;
	Mon, 18 Aug 2025 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516937;
	bh=yfZsEruc2SIJ9NNdIdJv3IchthpWf7/FEhASCOKz0L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pm4g2du4gTMztV97x/vVgz5Ja1r5t50+33S73Jhcp2OTU6EzX72PNJfe4CuvHfM9C
	 QqpDmdWmgE8U2b3ZrmVMFcyFSPWIBpRh6QVsphuRMj2qc0JgJOwhj/62GbM1jmLj4j
	 jusihQtnrtauS7Fp/cK/rpCRYBkZNXyt3tl9TmgW4rpEiQ8cDd28eQm7bvfk2mMZEp
	 NmLtTdRIvPksViUCVrcAjm+jD3F5ZzSpun9NgZCsJPXNIxavwplSHAp4vEWlR9veJc
	 lu6Wq64oywJepODfeh+veuMC1KPJzw0IdQ7dwj1AD5fSl0yPg9z9Cz9f7H1SvuhiFH
	 JnNsjjSRu7s+w==
Date: Mon, 18 Aug 2025 13:35:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
Message-ID: <20250818133533.153742ed@foz.lan>
In-Reply-To: <fc93e36f-7503-430d-a611-983f0325ab1b@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
	<773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
	<20250816135538.733b80d3@foz.lan>
	<acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
	<20250817133606.79d968ed@sal.lan>
	<b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
	<20250817154544.78d61029@foz.lan>
	<b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
	<816ec5d2-33ea-4399-86e6-51ddc20ead28@gmail.com>
	<20250818114220.7f82d2f7@foz.lan>
	<fc93e36f-7503-430d-a611-983f0325ab1b@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 18 Aug 2025 19:06:03 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Mon, 18 Aug 2025 11:42:20 +0200, Mauro Carvalho Chehab wrote:
> > Em Mon, 18 Aug 2025 09:44:39 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:  
> >> Sidenote:
> >>
> >> It looks like texlive-xindy is not available for RHEL based distros.  
> > 
> > On several rpm-based distros, extra repositories are needed.
> > 
> > So, if you take a look at rpmfind:
> > 	https://rpmfind.net/linux/rpm2html/search.php?query=python3-sphinx  
> 
> No, I'm talking about texlive-xindy.
> 
>      https://rpmfind.net/linux/rpm2html/search.php?query=texlive-xindy
> 
> has RPMs for fedora 41/42/rawhide only.
> 
> How do you install xindy under AlmaLinux release 9.6 (Sage Margay),
> Amazon Linux release 2023 (Amazon Linux), CentOS Stream release 9,
> and the likes?

I didn't install it there. 

Yet, on some distros it seems that this is packaged together with
a texlive collection package and it is called during pdf build. 

This was also causing font issues. So, I added an option at 
latex_elements to ensure that, if used, it will request UTF-8 fonts:

	latex_elements = {
	    # The paper size ('letterpaper' or 'a4paper').
	    "papersize": "a4paper",
	    "passoptionstopackages": dedent(r"""
	        \PassOptionsToPackage{svgnames}{xcolor}
	        % Avoid encoding troubles when creating indexes
	        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
	    """),

I just built manually on almalinux. There, all pdfs built fine:

<snip>
Summary
=======
dev-tools      : pdf/dev-tools.pdf
tools          : pdf/tools.pdf
filesystems    : pdf/filesystems.pdf
w1             : pdf/w1.pdf
maintainer     : pdf/maintainer.pdf
process        : pdf/process.pdf
isdn           : pdf/isdn.pdf
fault-injection: pdf/fault-injection.pdf
iio            : pdf/iio.pdf
scheduler      : pdf/scheduler.pdf
staging        : pdf/staging.pdf
fpga           : pdf/fpga.pdf
power          : pdf/power.pdf
leds           : pdf/leds.pdf
edac           : pdf/edac.pdf
PCI            : pdf/PCI.pdf
firmware-guide : pdf/firmware-guide.pdf
cpu-freq       : pdf/cpu-freq.pdf
mhi            : pdf/mhi.pdf
wmi            : pdf/wmi.pdf
timers         : pdf/timers.pdf
accel          : pdf/accel.pdf
hid            : pdf/hid.pdf
userspace-api  : pdf/userspace-api.pdf
spi            : pdf/spi.pdf
networking     : pdf/networking.pdf
virt           : pdf/virt.pdf
nvme           : pdf/nvme.pdf
translations   : pdf/translations.pdf
input          : pdf/input.pdf
tee            : pdf/tee.pdf
doc-guide      : pdf/doc-guide.pdf
cdrom          : pdf/cdrom.pdf
gpu            : pdf/gpu.pdf
i2c            : pdf/i2c.pdf
RCU            : pdf/RCU.pdf
watchdog       : pdf/watchdog.pdf
usb            : pdf/usb.pdf
rust           : pdf/rust.pdf
crypto         : pdf/crypto.pdf
kbuild         : pdf/kbuild.pdf
livepatch      : pdf/livepatch.pdf
mm             : pdf/mm.pdf
locking        : pdf/locking.pdf
infiniband     : pdf/infiniband.pdf
driver-api     : pdf/driver-api.pdf
bpf            : pdf/bpf.pdf
devicetree     : pdf/devicetree.pdf
block          : pdf/block.pdf
target         : pdf/target.pdf
arch           : pdf/arch.pdf
pcmcia         : pdf/pcmcia.pdf
scsi           : pdf/scsi.pdf
netlabel       : pdf/netlabel.pdf
sound          : pdf/sound.pdf
security       : pdf/security.pdf
accounting     : pdf/accounting.pdf
admin-guide    : pdf/admin-guide.pdf
core-api       : pdf/core-api.pdf
fb             : pdf/fb.pdf
peci           : pdf/peci.pdf
trace          : pdf/trace.pdf
misc-devices   : pdf/misc-devices.pdf
kernel-hacking : pdf/kernel-hacking.pdf
hwmon          : pdf/hwmon.pdf

All PDF files were built.
</snip>

Those are all installed packages on AlmaLinux 9.6 (obtained only from 
sphinx-pre-install requirements):

<snip>
# rpm -q -a|grep texlive
texlive-base-20200406-26.el9_2.noarch
texlive-lib-20200406-26.el9_2.x86_64
texlive-texlive-common-doc-20200406-26.el9_2.noarch
texlive-cm-20200406-26.el9_2.noarch
texlive-etex-20200406-26.el9_2.noarch
texlive-graphics-def-20200406-26.el9_2.noarch
texlive-hyph-utf8-20200406-26.el9_2.noarch
texlive-hyphen-base-20200406-26.el9_2.noarch
texlive-knuth-lib-20200406-26.el9_2.noarch
texlive-plain-20200406-26.el9_2.noarch
texlive-tex-ini-files-20200406-26.el9_2.noarch
texlive-unicode-data-20200406-26.el9_2.noarch
texlive-texlive.infra-20200406-26.el9_2.noarch
texlive-luatex-20200406-26.el9_2.x86_64
texlive-texlive-scripts-20200406-26.el9_2.noarch
texlive-kpathsea-20200406-26.el9_2.x86_64
texlive-iftex-20200406-26.el9_2.noarch
texlive-atbegshi-20200406-26.el9_2.noarch
texlive-amsmath-20200406-26.el9_2.noarch
texlive-kvoptions-20200406-26.el9_2.noarch
texlive-babel-20200406-26.el9_2.noarch
texlive-etex-pkg-20200406-26.el9_2.noarch
texlive-etoolbox-20200406-26.el9_2.noarch
texlive-latex-fonts-20200406-26.el9_2.noarch
texlive-ltxcmds-20200406-26.el9_2.noarch
texlive-url-20200406-26.el9_2.noarch
texlive-amsfonts-20200406-26.el9_2.noarch
texlive-infwarerr-20200406-26.el9_2.noarch
texlive-pdftexcmds-20200406-26.el9_2.noarch
texlive-luatexbase-20200406-26.el9_2.noarch
texlive-atveryend-20200406-26.el9_2.noarch
texlive-auxhook-20200406-26.el9_2.noarch
texlive-etexcmds-20200406-26.el9_2.noarch
texlive-l3backend-20200406-26.el9_2.noarch
texlive-lm-20200406-26.el9_2.noarch
texlive-booktabs-20200406-26.el9_2.noarch
texlive-ec-20200406-26.el9_2.noarch
texlive-fancyhdr-20200406-26.el9_2.noarch
texlive-footmisc-20200406-26.el9_2.noarch
texlive-intcalc-20200406-26.el9_2.noarch
texlive-kvsetkeys-20200406-26.el9_2.noarch
texlive-multido-20200406-26.el9_2.noarch
texlive-natbib-20200406-26.el9_2.noarch
texlive-ulem-20200406-26.el9_2.noarch
texlive-zapfding-20200406-26.el9_2.noarch
texlive-catchfile-20200406-26.el9_2.noarch
texlive-babelbib-20200406-26.el9_2.noarch
texlive-bookmark-20200406-26.el9_2.noarch
texlive-epstopdf-pkg-20200406-26.el9_2.noarch
texlive-fonts-tlwg-20200406-26.el9_2.noarch
texlive-fp-20200406-26.el9_2.noarch
texlive-gettitlestring-20200406-26.el9_2.noarch
texlive-glyphlist-20200406-26.el9_2.noarch
texlive-graphics-cfg-20200406-26.el9_2.noarch
texlive-graphics-20200406-26.el9_2.noarch
texlive-tools-20200406-26.el9_2.noarch
texlive-xkeyval-20200406-26.el9_2.noarch
texlive-geometry-20200406-26.el9_2.noarch
texlive-colortbl-20200406-26.el9_2.noarch
texlive-carlisle-20200406-26.el9_2.noarch
texlive-caption-20200406-26.el9_2.noarch
texlive-sauerj-20200406-26.el9_2.noarch
texlive-grfext-20200406-26.el9_2.noarch
texlive-hycolor-20200406-26.el9_2.noarch
texlive-kvdefinekeys-20200406-26.el9_2.noarch
texlive-latexconfig-20200406-26.el9_2.noarch
texlive-letltxmacro-20200406-26.el9_2.noarch
texlive-lua-alt-getopt-20200406-26.el9_2.noarch
texlive-marvosym-20200406-26.el9_2.noarch
texlive-mptopdf-20200406-26.el9_2.noarch
texlive-paralist-20200406-26.el9_2.noarch
texlive-pdfescape-20200406-26.el9_2.noarch
texlive-pdftex-20200406-26.el9_2.x86_64
texlive-placeins-20200406-26.el9_2.noarch
texlive-refcount-20200406-26.el9_2.noarch
texlive-setspace-20200406-26.el9_2.noarch
texlive-stringenc-20200406-26.el9_2.noarch
texlive-svn-prov-20200406-26.el9_2.noarch
texlive-everyhook-20200406-37.el9.noarch
texlive-symbol-20200406-26.el9_2.noarch
texlive-psnfss-20200406-26.el9_2.noarch
texlive-tex-20200406-26.el9_2.x86_64
texlive-uniquecounter-20200406-26.el9_2.noarch
texlive-rerunfilecheck-20200406-26.el9_2.noarch
texlive-wasy-20200406-26.el9_2.noarch
texlive-zref-20200406-26.el9_2.noarch
texlive-adobemapping-20200406-37.el9.noarch
texlive-firstaid-20200406-37.el9.noarch
texlive-ipaex-20200406-37.el9.noarch
texlive-latex-base-dev-20200406-37.el9.noarch
texlive-latex-firstaid-dev-20200406-37.el9.noarch
texlive-ptex-base-20200406-37.el9.noarch
texlive-ptex-fonts-20200406-37.el9.noarch
texlive-uptex-fonts-20200406-37.el9.noarch
texlive-wasy-type1-20200406-26.el9_2.noarch
texlive-subfig-20200406-26.el9_2.noarch
texlive-breakurl-20200406-26.el9_2.noarch
texlive-qstest-20200406-26.el9_2.noarch
texlive-sttools-20200406-37.el9.noarch
texlive-csquotes-20200406-26.el9_2.noarch
texlive-translator-20200406-26.el9_2.noarch
texlive-japanese-otf-20200406-37.el9.noarch
texlive-japanese-otf-uptex-20200406-37.el9.noarch
texlive-euro-20200406-26.el9_2.noarch
texlive-garuda-c90-20200406-26.el9_2.noarch
texlive-norasi-c90-20200406-26.el9_2.noarch
texlive-ifplatform-20200406-26.el9_2.noarch
texlive-dvips-20200406-26.el9_2.x86_64
texlive-memoir-20200406-26.el9_2.noarch
texlive-tex-gyre-20200406-26.el9_2.noarch
texlive-alphalph-20200406-26.el9_2.noarch
texlive-arphic-20200406-26.el9_2.noarch
texlive-avantgar-20200406-26.el9_2.noarch
texlive-babel-english-20200406-26.el9_2.noarch
texlive-beton-20200406-26.el9_2.noarch
texlive-bibtex-20200406-26.el9_2.x86_64
texlive-bigintcalc-20200406-26.el9_2.noarch
texlive-bitset-20200406-26.el9_2.noarch
texlive-bookman-20200406-26.el9_2.noarch
texlive-changepage-20200406-26.el9_2.noarch
texlive-charter-20200406-26.el9_2.noarch
texlive-chngcntr-20200406-26.el9_2.noarch
texlive-cmextra-20200406-26.el9_2.noarch
texlive-cns-20200406-26.el9_2.noarch
texlive-colorprofiles-20200406-26.el9_2.noarch
texlive-courier-20200406-26.el9_2.noarch
texlive-enctex-20200406-26.el9_2.noarch
texlive-enumitem-20200406-26.el9_2.noarch
texlive-euler-20200406-26.el9_2.noarch
texlive-eurosym-20200406-26.el9_2.noarch
texlive-filecontents-20200406-26.el9_2.noarch
texlive-fix2col-20200406-26.el9_2.noarch
texlive-float-20200406-26.el9_2.noarch
texlive-fpl-20200406-26.el9_2.noarch
texlive-grffile-20200406-26.el9_2.noarch
texlive-helvetic-20200406-26.el9_2.noarch
texlive-hobsub-20200406-26.el9_2.noarch
texlive-hyperref-20200406-26.el9_2.noarch
texlive-latex-20200406-26.el9_2.noarch
texlive-tipa-20200406-26.el9_2.noarch
texlive-xunicode-20200406-26.el9_2.noarch
texlive-amscls-20200406-26.el9_2.noarch
texlive-ae-20200406-26.el9_2.noarch
texlive-algorithms-20200406-26.el9_2.noarch
texlive-bera-20200406-26.el9_2.noarch
texlive-cm-super-20200406-26.el9_2.noarch
texlive-ucs-20200406-26.el9_2.noarch
texlive-attachfile-20200406-26.el9_2.noarch
texlive-hologo-20200406-26.el9_2.noarch
texlive-hyphenex-20200406-26.el9_2.noarch
texlive-ifmtarg-20200406-26.el9_2.noarch
texlive-xifthen-20200406-26.el9_2.noarch
texlive-index-20200406-26.el9_2.noarch
texlive-kastrup-20200406-26.el9_2.noarch
texlive-knuth-local-20200406-26.el9_2.noarch
texlive-lm-math-20200406-26.el9_2.noarch
texlive-luahbtex-20200406-26.el9_2.x86_64
texlive-lualibs-20200406-26.el9_2.noarch
texlive-luaotfload-20200406-26.el9_2.noarch
texlive-makecmds-20200406-26.el9_2.noarch
texlive-makeindex-20200406-26.el9_2.x86_64
texlive-manfnt-font-20200406-26.el9_2.noarch
texlive-marginnote-20200406-26.el9_2.noarch
texlive-mathpazo-20200406-26.el9_2.noarch
texlive-mflogo-20200406-26.el9_2.noarch
texlive-mflogo-font-20200406-26.el9_2.noarch
texlive-mfnfss-20200406-26.el9_2.noarch
texlive-mfware-20200406-26.el9_2.x86_64
texlive-modes-20200406-26.el9_2.noarch
texlive-mparhack-20200406-26.el9_2.noarch
texlive-ncntrsbk-20200406-26.el9_2.noarch
texlive-notoccite-20200406-26.el9_2.noarch
texlive-minitoc-20200406-26.el9_2.noarch
texlive-ltxmisc-20200406-26.el9_2.noarch
texlive-palatino-20200406-26.el9_2.noarch
texlive-parallel-20200406-26.el9_2.noarch
texlive-pdfcolmk-20200406-26.el9_2.noarch
texlive-xcolor-20200406-26.el9_2.noarch
texlive-pgf-20200406-26.el9_2.noarch
texlive-currfile-20200406-26.el9_2.noarch
texlive-filehook-20200406-26.el9_2.noarch
texlive-sansmathaccent-20200406-26.el9_2.noarch
texlive-beamer-20200406-26.el9_2.noarch
texlive-eso-pic-20200406-26.el9_2.noarch
texlive-pslatex-20200406-26.el9_2.noarch
texlive-pspicture-20200406-26.el9_2.noarch
texlive-pst-arrow-20200406-26.el9_2.noarch
texlive-pst-math-20200406-26.el9_2.noarch
texlive-pxfonts-20200406-26.el9_2.noarch
texlive-rsfs-20200406-26.el9_2.noarch
texlive-soul-20200406-26.el9_2.noarch
texlive-tex-gyre-math-20200406-26.el9_2.noarch
texlive-texlive-docindex-20200406-26.el9_2.noarch
texlive-texlive-en-20200406-26.el9_2.noarch
texlive-texlive-msg-translations-20200406-26.el9_2.noarch
texlive-times-20200406-26.el9_2.noarch
texlive-titlesec-20200406-26.el9_2.noarch
texlive-trimspaces-20200406-26.el9_2.noarch
texlive-environ-20200406-26.el9_2.noarch
texlive-txfonts-20200406-26.el9_2.noarch
texlive-uhc-20200406-26.el9_2.noarch
texlive-underscore-20200406-26.el9_2.noarch
texlive-updmap-map-20200406-26.el9_2.noarch
texlive-utopia-20200406-26.el9_2.noarch
texlive-varwidth-20200406-26.el9_2.noarch
texlive-ms-20200406-26.el9_2.noarch
texlive-koma-script-20200406-26.el9_2.noarch
texlive-listings-20200406-26.el9_2.noarch
texlive-showexpl-20200406-26.el9_2.noarch
texlive-fancyvrb-20200406-26.el9_2.noarch
texlive-pst-3d-20200406-26.el9_2.noarch
texlive-pst-coil-20200406-26.el9_2.noarch
texlive-pst-eps-20200406-26.el9_2.noarch
texlive-pst-fill-20200406-26.el9_2.noarch
texlive-pst-grad-20200406-26.el9_2.noarch
texlive-pst-node-20200406-26.el9_2.noarch
texlive-pst-plot-20200406-26.el9_2.noarch
texlive-pst-text-20200406-26.el9_2.noarch
texlive-pst-tools-20200406-26.el9_2.noarch
texlive-pst-tree-20200406-26.el9_2.noarch
texlive-pstricks-add-20200406-26.el9_2.noarch
texlive-pstricks-20200406-26.el9_2.noarch
texlive-wadalab-20200406-26.el9_2.noarch
texlive-cjk-20200406-26.el9_2.noarch
texlive-wasysym-20200406-26.el9_2.noarch
texlive-xetexconfig-20200406-26.el9_2.noarch
texlive-zapfchan-20200406-26.el9_2.noarch
texlive-ascmac-20200406-37.el9.noarch
texlive-cjkpunct-20200406-37.el9.noarch
texlive-convbkmk-20200406-37.el9.noarch
texlive-fandol-20200406-37.el9.noarch
texlive-ttfutils-20200406-37.el9.x86_64
texlive-uptex-base-20200406-37.el9.noarch
texlive-zhmetrics-20200406-37.el9.noarch
texlive-zhmetrics-uptex-20200406-37.el9.noarch
texlive-xdvi-20200406-26.el9_2.x86_64
texlive-ptex-20200406-37.el9.x86_64
texlive-uptex-20200406-37.el9.x86_64
texlive-metafont-20200406-26.el9_2.x86_64
texlive-thumbpdf-20200406-26.el9_2.noarch
texlive-fontspec-20200406-26.el9_2.noarch
texlive-l3packages-20200406-26.el9_2.noarch
texlive-lualatex-math-20200406-26.el9_2.noarch
texlive-unicode-math-20200406-26.el9_2.noarch
texlive-oberdiek-20200406-26.el9_2.noarch
texlive-l3kernel-20200406-26.el9_2.noarch
texlive-xecjk-20200406-26.el9_2.noarch
texlive-dvipdfmx-20200406-26.el9_2.x86_64
texlive-xetex-20200406-26.el9_2.x86_64
texlive-collection-basic-20200406-26.el9_2.noarch
texlive-platex-20200406-37.el9.noarch
texlive-xcjk2uni-20200406-37.el9.noarch
texlive-xpinyin-20200406-37.el9.noarch
texlive-platex-tools-20200406-37.el9.noarch
texlive-uplatex-20200406-37.el9.noarch
texlive-luatexja-20200406-37.el9.noarch
texlive-zhnumber-20200406-37.el9.noarch
texlive-bidi-20200406-26.el9_2.noarch
texlive-polyglossia-20200406-26.el9_2.noarch
texlive-ctex-20200406-37.el9.noarch
texlive-collection-fontsrecommended-20200406-26.el9_2.noarch
texlive-collection-latex-20200406-26.el9_2.noarch
texlive-eqparbox-20200406-26.el9_2.noarch
texlive-upquote-20200406-26.el9_2.noarch
texlive-tabulary-20200406-26.el9_2.noarch
texlive-fncychap-20200406-26.el9_2.noarch
texlive-anyfontsize-20200406-26.el9_2.noarch
texlive-capt-of-20200406-26.el9_2.noarch
texlive-cmap-20200406-26.el9_2.noarch
texlive-euenc-20200406-26.el9_2.noarch
texlive-fancybox-20200406-26.el9_2.noarch
texlive-framed-20200406-26.el9_2.noarch
texlive-luatex85-20200406-26.el9_2.noarch
texlive-mdwtools-20200406-26.el9_2.noarch
texlive-multirow-20200406-26.el9_2.noarch
texlive-needspace-20200406-26.el9_2.noarch
texlive-parskip-20200406-26.el9_2.noarch
texlive-threeparttable-20200406-26.el9_2.noarch
texlive-wrapfig-20200406-26.el9_2.noarch
</snip>

Thanks,
Mauro

