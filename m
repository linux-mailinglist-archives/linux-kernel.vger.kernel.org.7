Return-Path: <linux-kernel+bounces-771963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ABFB28D46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C0316E66B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40FA29CB47;
	Sat, 16 Aug 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWvzQ8z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58D329B792;
	Sat, 16 Aug 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755342367; cv=none; b=RY/fe3983xLUNxF0kALgxOyjwUQPV9lps9bzBPdeGQ4NVhQXSft/xSpnByGU6GfJsCtwRrQ4g3YC6YpQIbOa7+Dv87WJDZx3OD3yZSeD/M+BgfA+wcOQz4pOqzpwALcvFRm0ovGDGOLqkhlCgf+nFTxoB61VMQ4xNZG3i0GlZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755342367; c=relaxed/simple;
	bh=ZYE7gCkuUa4edRy9otmNooqPGVtQEs0BNVd8uCfgHUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oB0Rzg4j6sIdTvgSwswSDKVy2V1JHU8NHPB+aMvu7FWvVno93IAFk0ceWhKpfNcY1pR6ybEccycBiLfLfcfYMax0BVqDd+qca6Ip6Dq3WJ4T4hbnobjhD4QBfb8Pvlgz6TJs+rbm9t2QYof1N7xs5qcRP5JCrfl00405Ys95+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWvzQ8z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2BBC4CEEF;
	Sat, 16 Aug 2025 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755342367;
	bh=ZYE7gCkuUa4edRy9otmNooqPGVtQEs0BNVd8uCfgHUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TWvzQ8z8UlxhPvxg0GjdfbLVPYvKCY7u3vQ3r2zAdu3oFGH6/nCbsv9ZEFkagTgqC
	 kBP4O2hYgGSv7qK4+T1vxJX/tD2teyqD0hmLo4D/WLPg9i50NnDwhLTt1r/iH/+EmC
	 9KO/BvZiwPf0O/jGmi+RZoZqtnH6KK/PClE5G8FAnQxp76fG3X+CVGey9kzDlcUhPn
	 dkRK0bMqctjBnBguQqhAKQxYgIWbMS3YdOjD7Rsy/mN0EMmklVAocM0ggYABqihMQ8
	 YPNI5Bn2o7zjax9HTcNRvf0ZPJu4X//+mPzbsuasgJwQKRZq9KWfI1SjeDzWwu1dc7
	 QnwN9p9a37p1Q==
Date: Sat, 16 Aug 2025 13:06:01 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: alex.gaynor@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, corbet@lwn.net, gary@garyguo.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH 04/11] scripts: sphinx-build-wrapper: add a wrapper for
 sphinx-build
Message-ID: <20250816130601.6f793f8c@foz.lan>
In-Reply-To: <9b3b0430-066f-486e-89cc-00e6f1f3b096@gmail.com>
References: <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
	<9b3b0430-066f-486e-89cc-00e6f1f3b096@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Sat, 16 Aug 2025 10:16:01 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi Mauro,
>=20
> On Fri, 15 Aug 2025 13:50:32 +0200, Mauro Carvalho Chehab wrote:
> > There are too much magic inside docs Makefile to properly run
> > sphinx-build. Create an ancillary script that contains all
> > kernel-related sphinx-build call logic currently at Makefile.
> >=20
> > Such script is designed to work both as an standalone command
> > and as part of a Makefile. As such, it properly handles POSIX
> > jobserver used by GNU make.
> >=20
> > It should be noticed that, when running the script alone,
> > it will only take care of sphinx-build and cleandocs target.
> > As such:
> >=20
> > - it won't run "make rustdoc";
> > - no extra checks.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .pylintrc                    |   2 +-
> >  scripts/sphinx-build-wrapper | 627 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 628 insertions(+), 1 deletion(-)
> >  create mode 100755 scripts/sphinx-build-wrapper
> >  =20
>=20
> [...]
>=20
> > diff --git a/scripts/sphinx-build-wrapper b/scripts/sphinx-build-wrapper
> > new file mode 100755
> > index 000000000000..5c728956b53c
> > --- /dev/null
> > +++ b/scripts/sphinx-build-wrapper
> > @@ -0,0 +1,627 @@ =20
>=20
> [...]
>=20
> > +    def handle_pdf(self, output_dirs):
> > +        """
> > +        Extra steps for PDF output.
> > +
> > +        As PDF is handled via a LaTeX output, after building the .tex =
file,
> > +        a new build is needed to create the PDF output from the latex
> > +        directory.
> > +        """
> > +        builds =3D {}
> > +        max_len =3D 0
> > +
> > +        for from_dir in output_dirs:
> > +            pdf_dir =3D os.path.join(from_dir, "../pdf")
> > +            os.makedirs(pdf_dir, exist_ok=3DTrue)
> > +
> > +            if self.latexmk_cmd:
> > +                latex_cmd =3D [self.latexmk_cmd, f"-{self.pdflatex}"]
> > +            else:
> > +                latex_cmd =3D [self.pdflatex]
> > +
> > +            latex_cmd.extend(shlex.split(self.latexopts))
> > +
> > +            tex_suffix =3D ".tex"
> > +
> > +            # Process each .tex file
> > +            has_tex =3D False
> > +            build_failed =3D False
> > +            with os.scandir(from_dir) as it:
> > +                for entry in it:
> > +                    if not entry.name.endswith(tex_suffix):
> > +                        continue
> > +
> > +                    name =3D entry.name[:-len(tex_suffix)]
> > +                    has_tex =3D True
> > +
> > +                    try:
> > +                        subprocess.run(latex_cmd + [entry.path],
> > +                                       cwd=3Dfrom_dir, check=3DTrue) =
=20
>=20
> So, runs of latexmk (or xelatex) would be serialized, wouldn't they?

I guess it is already serialized today, but haven't check. IMO,=20
not serializing it is not a good idea, due to the very noisy build
that LaTeX does.=20

> That would be a *huge* performance regression when I say:
>=20
>     "make -j10 -O pdfdocs"
>=20
> Current Makefile delegates .tex --> .pdf part of pdfdocs to sub make
> of .../output/Makefile, which is generated on-the-fly by Sphinx's
> latex builder.  That "-j10 -O" flag is passed to the sub make.

Well, the script could pick it from jobserver with something
like (untested):

	from concurrent import futures

	# When using make, this won't be used, as the number of jobs comes
	# from POSIX jobserver. So, this covers the case where build comes
	# from command line. On such case, serialize by default, except if
	# the user explicitly sets the number of jobs.
	n_jobs =3D 1
	if self.n_jobs:
            try:
	        n_jobs =3D int(self.n_jobs)
            except ValueError:
                pass

	with JobserverExec() as jobserver:
            if jobserver.claim:
                n_jobs =3D str(jobserver.claim)

	    fut =3D []
	    with futures.ThreadPoolExecutor(max_workers=3Dself.MAX_WORKERS) as ex:

	        fut.append(ex.submit(self.handle_pdf(output_dirs))

	    for f in futures.as_completed(fut):
	        # some logic to pick job results and wait for them to comlete

This way, when running from command line without "-j" it would serialize
(with is good for debugging). Otherwise, it will pick the maximum number
of available jobs or the -j argument and create one process for each.

> Another issue is that you are not deny-listing variable Noto CJK
> fonts for latexmk/xelatex.  So this version of wrapper won't be able
> to build translations.pdf if you have such variable fonts installed.

It did build it on several distributions:

	almalinux_report.log:        translations             : PASSED: pdf/transl=
ations.pdf
	amazonlinux_report.log:        translations             : PASSED: pdf/tran=
slations.pdf
	centos_report.log:        translations             : PASSED: pdf/translati=
ons.pdf
	fedora_report.log:        translations             : PASSED: pdf/translati=
ons.pdf
	kali_report.log:        translations             : PASSED: pdf/translation=
s.pdf
	mageia_report.log:        translations             : PASSED: pdf/translati=
ons.pdf
	opensuse-leap_report.log:        translations             : PASSED: pdf/tr=
anslations.pdf
	opensuse_report.log:        translations             : PASSED: pdf/transla=
tions.pdf
	rockylinux8_report.log:        translations             : PASSED: pdf/tran=
slations.pdf
	ubuntu_report.log:        translations             : PASSED: pdf/translati=
ons.pdf

(to test, you need to have both this series and the pdf fixes one
altogether - as I found some bugs related to it that were addressed
there)

> That failuer is not caught by your ad-hoc logic below.
>=20
> > +                    except subprocess.CalledProcessError:
> > +                        # LaTeX PDF error code is almost useless: it r=
eturns
> > +                        # error codes even when build succeeds but has=
 warnings.
> > +                        pass
> > +
> > +                    # Instead of checking errors, let's do the next be=
st thing:
> > +                    # check if the PDF file was actually created. =20

It is intentional. Even when everything passes, because of the
thousands of warnings, this always return an error code.

What the logic does, instead, is to ignore the bogus return code from
PDF builds, looking, instead if file is present, reporting, at the end:

	Summary
	=3D=3D=3D=3D=3D=3D=3D
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

and returning 0 if all of the above were built. At the above,
all PDF files were built.

If one of the files is not built, it reports, instead:

	...
	accel          : pdf/accel.pdf
	hid            : pdf/hid.pdf
	userspace-api  : FAILED
	spi            : pdf/spi.pdf
	networking     : pdf/networking.pdf
	virt           : pdf/virt.pdf
	nvme           : pdf/nvme.pdf
	translations   : FAILED
	input          : pdf/inp
	...


In this specific example (pick from Mint build), userspace-api and
translations failed, among others:

	$ grep -Ei "^\w.*: FAILED" mint_report.log=20
	userspace-api  : FAILED
	translations   : FAILED
	doc-guide      : FAILED
	gpu            : FAILED
	i2c            : FAILED
	RCU            : FAILED
	arch           : FAILED
	core-api       : FAILED

Clearly, the failure there were not specific to translations,
and it is distro-specific.

One of the possible causes could be distro specific LaTeX config limits=20
for things like secnumdepth, tocdepth, ... and memory limits.

For instance, Mint has this main memory limit:

	/usr/share/texlive/texmf-dist/web2c/texmf.cnf:main_memory =3D 5000000 % wo=
rds of inimemory available; also applies to inimf&mp

while Fedora uses a higher limit:
	/etc/texlive/web2c/texmf.cnf:main_memory =3D 6000000 % words of inimemory =
available; also applies to inimf&mp

In the past, I had to fix several of those to generate PDFs on
Debian 11 and older Fedora. The fix is distro-specific.

-

If you look at the results I placed at the pdf series, on those distros,
all PDF files including translations were built:

	PASSED - AlmaLinux release 9.6 (Sage Margay) (7 tests)
	PASSED - Amazon Linux release 2023 (Amazon Linux) (7 tests)
	PASSED - CentOS Stream release 9 (7 tests)
	PASSED - Fedora release 42 (Adams) (7 tests)
	PASSED - Kali GNU/Linux 2025.2 (7 tests)
	PASSED - Mageia 9 (7 tests)
	PASSED - openSUSE Leap 15.6 (7 tests)
	PASSED - openSUSE Tumbleweed (7 tests)
	PASSED - Ubuntu 25.04 (7 tests)

> I've seen cases where a corrupt .pdf file is left after premature crashes
> of xdvipdfmx.  So, checking .pdf is not good enough for determining
> success/failure.
>=20
> One way to see if a .pdf file is properly formatted would be to run
> "pdffonts" against the resulting .pdf.
>=20
> For example, if I run "pdffonts translations.pdf" against the corrupted
> one, I get:
>=20
>    Syntax Error: Couldn't find trailer dictionary
>    Syntax Error: Couldn't find trailer dictionary
>    Syntax Error: Couldn't read xref table
>=20
> , with the exit code of 1.
> Against a successfully built translations.pdf, I get something like:
>=20
> name                                 type              encoding         e=
mb sub uni object ID
> ------------------------------------ ----------------- ---------------- -=
-- --- --- ---------
> JPRCQB+DejaVuSans-Bold               CID TrueType      Identity-H       y=
es yes yes      4  0
> QFNXFP+DejaVuSerif-Bold              CID TrueType      Identity-H       y=
es yes yes     13  0
> NMFBZR+NotoSerifCJKjp-Bold-Identity-H CID Type 0C       Identity-H       =
yes yes yes     15  0
> WYMCYC+NotoSansCJKjp-Black-Identity-H CID Type 0C       Identity-H       =
yes yes yes     32  0
> [...]
>=20

Running it at the Fedora container shows that CJK fonts are there:

	$ pdffonts Documentation/output/pdf/translations.pdf
        name                                 type              encoding    =
     emb sub uni object ID
        ------------------------------------ ----------------- ------------=
---- --- --- --- ---------
        JOMCYL+DejaVuSans-Bold               CID TrueType      Identity-H  =
     yes yes yes      4  0
        HKSYWD+DejaVuSerif-Bold              CID TrueType      Identity-H  =
     yes yes yes     13  0
        TMISTH+NotoSansCJKjp-Black-Identity-H CID Type 0C       Identity-H =
      yes yes yes     15  0
        FCMOXF+NotoSansCJKjp-Black-Identity-H CID Type 0C       Identity-H =
      yes yes yes     32  0
        IPEVCV+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes     34  0
        UHCJPQ+DejaVuSerif                   CID TrueType      Identity-H  =
     yes yes yes     36  0
        ZPKIZY+DejaVuSerif-Italic            CID TrueType      Identity-H  =
     yes yes yes     41  0
        QIGBJX+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes     44  0
        FHPART+CMMI6                         Type 1C           Builtin     =
     yes yes no     244  0
        DHNQVK+CMSY6                         Type 1C           Builtin     =
     yes yes yes    245  0
        OFGXYL+DejaVuSerif-BoldItalic        CID TrueType      Identity-H  =
     yes yes yes    415  0
        SKLJTY+NotoSansCJKjp-Bold-Identity-H CID Type 0C       Identity-H  =
     yes yes yes    503  0
        JXTNEV+MSAM10                        Type 1C           Builtin     =
     yes yes yes    618  0
        KEIGKE+CMSY10                        Type 1C           Builtin     =
     yes yes yes    637  0
        GOHSWX+DejaVuSans                    CID TrueType      Identity-H  =
     yes yes yes    941  0
        IVVPKU+CMMI10                        Type 1C           Builtin     =
     yes yes yes   1592  0
        XAQAVF+CMR10                         Type 1C           Builtin     =
     yes yes yes   1593  0
        TAUDRW+CMR8                          Type 1C           Builtin     =
     yes yes yes   1594  0
        AMQGFF+CMMI8                         Type 1C           Builtin     =
     yes yes yes   1595  0
        ETSVZG+CMSY8                         Type 1C           Builtin     =
     yes yes yes   1596  0
        NREKPL+NimbusRoman-Regular           Type 1C           WinAnsi     =
     yes yes yes   2508  0
        ZYNGMU+NotoSansCJKjp-Regular         CID Type 0C       Identity-H  =
     yes yes yes   2519  0
        EITFCN+NotoSansCJKjp-Black-Identity-H CID Type 0C       Identity-H =
      yes yes yes   3782  0
        ZDUUCF+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes   3787  0
        SAYAHH+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes   3848  0
        QFVHQT+NotoSansCJKjp-Bold-Identity-H CID Type 0C       Identity-H  =
     yes yes yes   4172  0
        OGQDEG+DejaVuSansMono                CID TrueType      Identity-H  =
     yes yes yes   5311  0
        QFJUVY+DejaVuSans-BoldOblique        CID TrueType      Identity-H  =
     yes yes yes   5502  0
        JYGYZI+DejaVuSansMono-Bold           CID TrueType      Identity-H  =
     yes yes yes   5607  0
        UBBPKA+DejaVuSansMono-Oblique        CID TrueType      Identity-H  =
     yes yes yes   5733  0
        LRVSWG+NimbusRoman-Regular           Type 1C           WinAnsi     =
     yes yes yes   6299  0
        KCVHZZ+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes   6583  0
        NKLOXT+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes   6602  0
        URSEFI+NotoSansCJKjp-Black-Identity-H CID Type 0C       Identity-H =
      yes yes yes   6814  0
        MDHJPT+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes   6819  0
        UVENXR+NotoSansCJKjp-Regular-Identity-H CID Type 0C       Identity-=
H       yes yes yes   6841  0

On Leap, It reports:

	opensuse-leap-test:~ # pdffonts Documentation/output/pdf/translations.pdf
	name                                 type              encoding         em=
b sub uni object ID
	------------------------------------ ----------------- ---------------- --=
- --- --- ---------
	JXGSQR+DejaVuSans-Bold               CID TrueType      Identity-H       ye=
s yes yes      4  0
	HQDZTS+DejaVuSerif-Bold              CID TrueType      Identity-H       ye=
s yes yes     13  0
	RHJSVS+DejaVuSerif                   CID TrueType      Identity-H       ye=
s yes yes     26  0
	YMIDKW+DejaVuSansMono                CID TrueType      Identity-H       ye=
s yes yes     28  0
	AQCTYG+DejaVuSerif-Italic            CID TrueType      Identity-H       ye=
s yes yes     37  0
	DYBJGY+CMMI6                         Type 1C           Builtin          ye=
s yes no     166  0
	PVSXRL+CMSY6                         Type 1C           Builtin          ye=
s yes yes    167  0
	OKDRKF+DejaVuSans-BoldOblique        CID TrueType      Identity-H       ye=
s yes yes    294  0
	UATVDQ+DejaVuSerif-BoldItalic        CID TrueType      Identity-H       ye=
s yes yes    342  0
	HMMWHY+DejaVuSansMono-Bold           CID TrueType      Identity-H       ye=
s yes yes    401  0
	ZNFJHG+DejaVuSans                    CID TrueType      Identity-H       ye=
s yes yes    408  0
	YVEKLE+DejaVuSansMono-Oblique        CID TrueType      Identity-H       ye=
s yes yes    529  0
	RKPRBN+MSAM10                        Type 1C           Builtin          ye=
s yes yes    625  0
	AKVBFL+CMSY10                        Type 1C           Builtin          ye=
s yes yes    640  0
	QFXNIX+TeXGyreTermes-Regular         Type 1C           WinAnsi          ye=
s yes yes   1103  0
	PZNVGF+TeXGyreTermes-Regular         Type 1C           WinAnsi          ye=
s yes yes   1111  0

No CJK fonts there, which is already expected, as fonts were installed per =
sphinx-pre-install,
which explicitly says it currently doesn't add CJK fonts on OpenSUSE:

	      # FIXME: add support for installing CJK fonts
	      #
	      # I tried hard, but was unable to find a way to install
	      # "Noto Sans CJK SC" on openSUSE

For both cases, pdffonts didn't report any syntax error warnings.
So, for me it is working fine on both cases: when CJK is available and
when it is missing.

-

Now, with regards of automating a check with pdffonts, current
build process doesn't do it; it follows the typical assumption
that, when a make target produces a file, such file is not
corrupted.

Now, I don't mind having a consistency check after the build to
verify if the pdf file is corrupted, but such kind of things
deserve its own specific series.

As you know a lot more about that and CJK specific dependencies,=20
if you think this is important, feel free to could craft such test
and add it later at the wrapper. On such series, it would also
be worth to suggest installing poppler-utils/poppler-tools at
scripts/sphinx-pre-install.

The logic at sphinx-build-wrapper would then check if pdftools
is installed, before running the consistency checks that need it.

> So I have to say this version of your wrapper does not look quite
> ready to replace what you call "too much magic inside docs Makefile".

=46rom what I got, the only missing piece is the parallel build.

I'll craft an extra patch for it.

Thanks,
Mauro

