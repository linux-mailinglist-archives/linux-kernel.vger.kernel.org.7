Return-Path: <linux-kernel+bounces-822901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB3B84EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A1E7B609B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5AA234966;
	Thu, 18 Sep 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMiwcRYP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187B1230BCC;
	Thu, 18 Sep 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203907; cv=none; b=l89ytteulXf0mpJfUN385oNNUCpZKLbr1NgI5KiAAgMgNbBIRosROw1MsRRqnbYv40vqlB2LLE29qZTvIjJM3E3q/0/1eBt7Qn5o/V3qxP+rK9hCUUlsBTgEHalyF4rXhIrqLdN6patL1+/ZQcOqr1cUCrXTdMXEMQKujIm3XMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203907; c=relaxed/simple;
	bh=qoMSLquhGsUEeYosZZieHvZQCyLrteuZ8g3vPImGhK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeCvfKzcSy43I8gmzU1CAk9juMmbYhJOCM11wzl21iD2EFXMRBsF0+crOo/qF6cHqKud+4GNUYZPkIL0ceovN86/ucQH667PfYITB/ns0uj98Hlcp/1wM03zVGede0oeWIYONRfhNBfGUq5stmJkcV2r6AWkSEUhTNll34WMfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMiwcRYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67425C4CEEB;
	Thu, 18 Sep 2025 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758203906;
	bh=qoMSLquhGsUEeYosZZieHvZQCyLrteuZ8g3vPImGhK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VMiwcRYPJw1RVYyBAKkzB7ws62wlezGI7sZko4yjOZdrZnZHZxVoECxIQZazdWZKr
	 qGyNPT9qUyF2nDolW8+O9c9leed6AW2aXyauZfE1UwzmFs3CVtCeNc8ENVzn5OX7L9
	 0jjeDL3klhIujvd3Dzgt3fJQbbmBV+fxtjhkmTXKelnbguevKUVDikqPKF8hWyoJBM
	 6Mb/8rlU3oeCA5jsSFF+/hpRUcs6DM1SF6e7/aHP8Rlf+4IzfN+fBRj87/J9yQrkX5
	 tYWomdg9EmjOyHe3HyK7xAku+SyUPexZwGv4PK3kRZNLHb0PJesVH7hNqzFfojp9sy
	 Qa6k9YrTJLtFg==
Date: Thu, 18 Sep 2025 15:58:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Jani Nikula
 <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v7 11/24] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250918155822.69548064@foz.lan>
In-Reply-To: <5031e0c4-f17e-41b8-8955-959989e797f2@gmail.com>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
	<820f986c9b61637e5af6708a014e36d70740bcb7.1758111077.git.mchehab+huawei@kernel.org>
	<5031e0c4-f17e-41b8-8955-959989e797f2@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Sep 2025 21:07:10 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [+CC: Jani, -CC: rust people and list]
> 
> Hi, (just got v8, but sending anyway ...)
> 
> Now that I could actually apply v7 of the series, here is a
> (not-so-much knee-jerk) reaction to this change.
> Please see below.
> 
> On Wed, 17 Sep 2025 14:15:05 +0200, Mauro Carvalho Chehab wrote:
> > There are too much magic inside docs Makefile to properly run
> > sphinx-build. Create an ancillary script that contains all
> > kernel-related sphinx-build call logic currently at Makefile.
> > 
> > Such script is designed to work both as an standalone command
> > and as part of a Makefile. As such, it properly handles POSIX
> > jobserver used by GNU make.
> > 
> > On a side note, there was a line number increase due to the
> > conversion (ignoring comments) is:
> > 
> >  Documentation/Makefile          |  131 +++----------
> >  tools/docs/sphinx-build-wrapper |  293 +++++++++++++++++++++++++++++++
> >  2 files changed, 323 insertions(+), 101 deletions(-)
> > 
> > Comments and descriptions adds:
> >  tools/docs/sphinx-build-wrapper | 261 +++++++++++++++++++++++++++++++-
> > 
> > So, about half of the script are comments/descriptions.
> > 
> > This is because some things are more verbosed on Python and because
> > it requires reading env vars from Makefile. Besides it, this script
> > has some extra features that don't exist at the Makefile:
> > 
> > - It can be called directly from command line;
> > - It properly return PDF build errors.
> > 
> > When running the script alone, it will only take handle sphinx-build
> > targets. On other words, it won't runn make rustdoc after building
> > htmlfiles, nor it will run the extra check scripts.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile          | 129 ++-----
> >  tools/docs/sphinx-build-wrapper | 599 ++++++++++++++++++++++++++++++++
> >  2 files changed, 627 insertions(+), 101 deletions(-)
> >  create mode 100755 tools/docs/sphinx-build-wrapper
> > 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index fd6399c79fab..380284026c13 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile  
> [...]
> 
> > +# Common documentation targets
> > +infodocs texinfodocs latexdocs epubdocs xmldocs pdfdocs linkcheckdocs:
> > +	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
> > +	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
> > +		--sphinxdirs="$(SPHINXDIRS)" --conf="$(SPHINX_CONF)" \
> > +		--builddir="$(BUILDDIR)" --deny-vf=$(FONTS_CONF_DENY_VF) \
> > +		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
> >    
> [...]
> > +# Special handling for pdfdocs
> > +ifneq ($(shell which $(PDFLATEX) >/dev/null 2>&1; echo $$?),0)
> > +pdfdocs:
> > +	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
> > +	@echo "  SKIP    Sphinx $@ target."
> >  endif  
> [...]
> 
> > +	$(Q)@$(srctree)/tools/docs/sphinx-pre-install --version-check
> > +	+$(Q)$(PYTHON3) $(BUILD_WRAPPER) $@ \
> > +		--sphinxdirs="$(SPHINXDIRS)" --conf="$(SPHINX_CONF)" \
> > +		--builddir="$(BUILDDIR)" \
> > +		--theme=$(DOCS_THEME) --css=$(DOCS_CSS) --paper=$(PAPER)
> >  # If Rust support is available and .config exists, add rustdoc generated contents.
> >  # If there are any, the errors from this make rustdoc will be displayed but
> >  # won't stop the execution of htmldocs
> > @@ -118,49 +85,6 @@ ifeq ($(CONFIG_RUST),y)
> >  endif
> >  endif
> >    
> [...]
> 
> > -
> > -latexdocs:
> > -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> > -	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
> > -
> > -ifeq ($(HAVE_PDFLATEX),0)
> > -
> > -pdfdocs:
> > -	$(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
> > -	@echo "  SKIP    Sphinx $@ target."
> > -
> > -else # HAVE_PDFLATEX
> > -
> > -pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
> > -pdfdocs: latexdocs  
> 
> So, this is removing explicit dependency from pdfdocs to latexdocs.

No, this doesn't change it. See, pdfdocs is now a target. The logic
inside the wrapper will first build latexdocs with:

                try:
                    self.run_sphinx(sphinxbuild, build_args, env=self.env)
                except (OSError, ValueError, subprocess.SubprocessError) as e:
                    sys.exit(f"Build failed: {repr(e)}")

...

        if target == "pdfdocs":
            self.handle_pdf(output_dirs, deny_vf)
        elif target == "infodocs":
            self.handle_info(output_dirs)

e.g if build fails (SubprocessError), it will report it and won't build
pdf.

> Although it is rare, there is a small chance where Sphinx latex builder
> crashes and can't complete generating all the necessary files (.tex, .sty).

There is also another possibility, not currently covered:

	SPHINXDIRS="non_existing_dir"

if non_existing_dir is not at latex_documents, this may silently
succeed. The new logic detect this as well, producing a warning
that sphinx-build didn't produce any LaTeX .tex files. See at
handle_pdf() method:

        #
        # Handle case where no .tex files were found
        #
        if not has_tex:
            out_name = "LaTeX files"
            max_len = max(max_len, len(out_name))
            builds[out_name] = "FAILED: no .tex files were generated"
            build_failed = True

> 
> In such cases, I want "make pdfdocs" to give up immediately and not to
> try to run $(PDFLATEX) at all.

The doc Makefile has this:

	# Special handling for pdfdocs
	ifneq ($(shell which $(PDFLATEX) >/dev/null 2>&1; echo $$?),0)
	pdfdocs:
	        $(warning The '$(PDFLATEX)' command was not found. Make sure you have it installed and in PATH to produce PDF output.)
	        @echo "  SKIP    Sphinx $@ target."
	endif

	endif # HAVE_SPHINX

so, in thesis, it should get such condition early.

> It looks like "./tools/docs/sphinx-build-wrapper pdfdocs" doesn't give up
> at the latexdocs stage in such cases with default SPHINXDIRS="." and
> continues to run $(PDFLATEX) anyway.

If you run the script by hand and xelatex is not installed, it will
build *.tex files, failing only at .pdf output. I don't think this is
a problem, although it would be easy to add a logic there to verify
if PDFDOCS is there:

        self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
	if not os.path.exists(self.pdflatex) or not os.access(self.pdflatex, os.X_OK):
		sys.exit(f"Error: {self.pdflatex} doesn't exist or it is not executable")
	
But IMHO this is overkill.

> As a matter of fact, recent linux-next does exhibit such crashes in the
> latexdocs stage:
> 
> As of next-20250917, running:
>     make cleandocs: make pdfdocs" will end up in this way:
> 
> --------------------------------------------------------------
> [...]
> Markup is unsupported in LaTeX!
> 
> Versions
> ========
> 
> [...]
> 
> Last Messages
> =============
> 
>         filesystems/xfs/xfs-delayed-logging-design
>         filesystems/xfs/xfs-maintainer-entry-profile
>         filesystems/xfs/xfs-self-describing-metadata
>         filesystems/xfs/xfs-online-fsck-design
>        filesystems/zonefs
> 
>     resolving references...
>     processing filesystems.tex: done
>     writing...
>     failed
> 
> Loaded Extensions
> =================
> 
> [...]
> 
> Traceback
> =========
> 
>       File "/[...]/sphinx-8.2.3/lib/python3.12/site-packages/sphinx/writers/latex.py", line 1152, in visit_table
>         raise UnsupportedError(
>     sphinx.writers.latex.UnsupportedError: filesystems/f2fs:: longtable does not support nesting a table.

Here, xelatex exists and was installed. This sounds to be due to some
change at fs2fs.rst file. Probably it is using a nested table, e.g.
a Sphinx table with a table inside it.

We had to do some changes on media to avoid that, as this indeed
breaks PDF generation.

> [...]
> 
> make[2]: *** [Documentation/Makefile:138: latexdocs] Error 2
> make[1]: *** [/home/akira/git/linux/Makefile:1805: pdfdocs] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> --------------------------------------------------------------
> 
> If you merge your v7 series into linux-next and resolve confilcts properly,
> running the same:
> 
>     make cleandocs; make pdfdocs
> 
> will end in this way:
> 
> Error: Can't build 45 PDF file(s): pdf/RCU.pdf, pdf/admin-guide.pdf, pdf/locking.pdf, pdf/dev-tools.pdf, pdf/process.pdf, pdf/core-api.pdf, pdf/mm.pdf, pdf/virt.pdf, pdf/block.pdf, pdf/sound.pdf, pdf/kernel-hacking.pdf, pdf/networking.pdf, pdf/infiniband.pdf, pdf/leds.pdf, pdf/maintainer.pdf, pdf/crypto.pdf, pdf/fb.pdf, pdf/accounting.pdf, pdf/livepatch.pdf, pdf/nvme.pdf, pdf/hid.pdf, pdf/isdn.pdf, pdf/trace.pdf, pdf/i2c.pdf, pdf/fault-injection.pdf, pdf/netlabel.pdf, pdf/staging.pdf, pdf/timers.pdf, pdf/firmware-guide.pdf, pdf/hwmon.pdf, pdf/scheduler.pdf, pdf/tools.pdf, pdf/watchdog.pdf, pdf/mhi.pdf, pdf/power.pdf, pdf/devicetree.pdf, pdf/arch.pdf, pdf/spi.pdf, pdf/userspace-api.pdf, pdf/translations.pdf, pdf/fpga.pdf, pdf/cpu-freq.pdf, pdf/security.pdf, pdf/bpf.pdf, pdf/pcmcia.pdf

It sounds that subprocess call is missing check=True. This should
likely fix it:

                try:
-                    self.run_sphinx(sphinxbuild, build_args, env=self.env) 
+                    self.run_sphinx(sphinxbuild, build_args, env=self.env, check=True)
                except (OSError, ValueError, subprocess.SubprocessError) as e:
                    sys.exit(f"Build failed: {repr(e)}")

without check=True, subprocess.call won't return an exception, but
instead will place the return code at the function return logic.


> As you might have already noticed, GNU Make provides useful and convinenent
> command options readily availabe.  Some of those I often use include:
...
> There are abundunt of other helpful options for various situations.
> 
> Your change of pdfdocs recipe would deprive me of those flexible options
> of GNU Make. 
...
> Honestly speaking, I just trunt the history proven tool much more than your
> re-implementation.  I'm sure I would miss that make--sub-make chain if your
> sphinx-build-wrapper were employed in pdfdocs target.

As explained, the build process we have is very complex, with lots of
exceptions and 4 separate scripts. We really need to have a consolidated
logic with everything on it and properly documented.

That's said, if you need to support your own particular scenario in
a way that you want to solve only with Makefile rules, you can easily
create your own Makefile.akira file with:

	pdfdocs:
		+make -C Documentation latexdocs
		+make -C Documentation/output/latex pdf

and whatever other specific rules you might want, but this doesn't
sound a valid reason to keep a very polluted badly documented Makefile,
where nobody knows exactly anymore why each part of it are there...

Heh, just on the discussions of this changeset, experienced
developers including me forgot that:

- _SPHINXDIRS is just a helper var for make help;
- the "|| exit" is there to bypass latex broken warnings;
- the media uapi builds (before -next) were missing a "+";
- there was an extra script called only when pdfdocs fail;
- it is hard to notice that make htmldocs actually ends with
	make rustdoc

> As I said above, the behavior you wants can be achieved by using a couple
> of options to GNU Make. (Give or take the "|| exit;" case.)
> I'm more inclined to continue using existing approach.
> 
> In summary, this is my suggestion for the development for the v6.19 (not v6.18)
> merge window.

Merging for 6.19 is OK to me. Maybe the best would be if Jon could merge v8
on a separate branch, to be merged after the merge window. We may then
send incremental patches against it containing fixes and improvements.

Keeping rebasing/resubmitting a /24 patches (and increasing) series every
time sounds a waste of everybody's time: if we agree with the general 
concept, we can submit things incrementally from now on.

> 1) Using sphinx-build-wrapper in (*}docs targets other than pdfdocs is the way
>    to go.
> 
> 2) pdfdocs should be a different target that depends on latexdocs.
> 
> 3) Preserve the make--sub-make chain in the pdfdocs recipe. (for easy access
>    to GNU Make's options)
> 
> 4) sphinx-build-wrapper has own its rights to cover pdfdocs.  I don't care
>    how it behaves when it is directly called for pdfdocs.

I think that splitting latex and pdf on two separate targets is not
a good idea for the normal usecase: most of the time, people just want
the final target and don't care what intermediate steps were needed to
build the output. 

-

Yet, perhaps we may implement either a "pdf-only" target that would
skip first step (sphinx-build) going directly to second step. Or maybe
implement on a more generic way, with something similar to:

	DOC_STEP=1|2

or:
	SPINXBUILD=0|1

To allow select what build step will be used or to skip sphinx-build
call.

> 5) Build summary as the final message from "make pdfdocs" is a good idea and
>    it should be doable in the Makefile recipe in a different manner.

Right now, summary is shown V=1, but we can add a way to control the
output directly.

> 6) The issue Mauro calls "false positive" (the "|| exit;" pattern in Makefile's
>    loop) might be a desired behavior, but it should be possible to add a knob
>    to suppress it in the Makefile.

Not against adding it. IMHO such scenario could be implemented
directly as an option to the wrapper when called from command line, 
instead of yet-another-env var, but I won't object either way.

> 
> Mauro, how does this "compromize" sound to you?

Yes. See my comments above.

> 
> Regards,
> Akira
> 
> > -	@$(srctree)/tools/docs/sphinx-pre-install --version-check
> > -	$(foreach var,$(SPHINXDIRS), \
> > -	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || $(PYTHON3) $(srctree)/tools/docs/check-variable-fonts.py || exit; \
> > -	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
> > -	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
> > -	)
> > -  
> [...]
> 



Thanks,
Mauro

