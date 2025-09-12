Return-Path: <linux-kernel+bounces-813556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE92DB54774
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DE17195D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0522D29D9;
	Fri, 12 Sep 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LszzpEuJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84273285CBB;
	Fri, 12 Sep 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668969; cv=none; b=p6I01d89/KGVR1yfxUwi/nKqoR5AjLUPvLEvxtaLJhk+2sL+EDk2QE2JjgTiFz6XUmBOooEHxascrnZwBVsjQfLlzAv536mhclH21pqZV2At1M+NqVNl0m1479TkGqP+WxTEE/8H3cSWR/5dt8O30WjOruoZu/KPLaxhPIcX8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668969; c=relaxed/simple;
	bh=44DPusRJnmdStqhj53nuUQKjQaThdwfwfltpNJC6McI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kmQC8fUI5zvuHzr8u7uC4xyqp5JL5TFefJnVAbDkirdQgJvL/fE8rEiBxeOaF1Ae8rNSJoRgT4RzGmhT+s63sgPqBKPpEMH85vHkzKAJIrQw0ErftOR+fowTiJwNUDbejRJ0Berqgl5/sXXc2ZGe+J4nwoR7VhnLBOsCO6wLoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LszzpEuJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757668967; x=1789204967;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=44DPusRJnmdStqhj53nuUQKjQaThdwfwfltpNJC6McI=;
  b=LszzpEuJbC0NRbL6ag6+rZX/duVxzB0pp9W7U2WFwG6iO4yBF+3ca+FX
   g5cfaQ2a6V6yXpONPAMVoYhZMbeFT7FQ14prxIuqL6H5RGleq1Jgr/id5
   8TBmiIlaEWTw/27JFuGmEMYPMuJJcyRvybLeBauf+iUPZ4ev2/Sut1JWn
   Y5feex9fa96sNXCeiD4fPsMOzoACnx1A7DOAZAb9vheMxK9GQAx0Q62U7
   DxcUt1y65fSO3L22Ep6Sgs7MQ05WqMV4lIoF6vRuronn9iyj6ntqvxZtU
   uam6yKTSZTFvPHQZ65tak5vZtapwE3HOlJxjUj4D+jdrgp6Z5K0Z683ZQ
   w==;
X-CSE-ConnectionGUID: MvfLpg1kRMmLDrcnxqKaKw==
X-CSE-MsgGUID: 0AoXxCIyT7CIy3Wu1a0tqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="77622490"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="77622490"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:22:47 -0700
X-CSE-ConnectionGUID: wvqQZKD9RIKZXSKb9YFitA==
X-CSE-MsgGUID: xGpQB1ieSBug0CGsOCfwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="179140539"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 02:22:45 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/19] tools/docs: sphinx-build-wrapper: add support
 to run inside venv
In-Reply-To: <20250912104639.4781b638@foz.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <2158cc4cf1f9bcf4c191f8031c1fb717cb989f7f.1756969623.git.mchehab+huawei@kernel.org>
 <b76575eab805884ee5227ae6f1aded505df4ec56@intel.com>
 <20250912104639.4781b638@foz.lan>
Date: Fri, 12 Sep 2025 12:22:42 +0300
Message-ID: <4d7acb77be634212056426aee139496da42dc520@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 12 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Em Wed, 10 Sep 2025 13:51:40 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
>
>> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>> > Sometimes, it is desired to run Sphinx from a virtual environment.
>> > Add a command line parameter to automatically build Sphinx from
>> > such environment.  
>> 
>> Why?
>
> In my case, to be able to test build with different Sphinx versions.
> On some distros, only venv works.

I mean why add the complexity of running inside a venv in the wrapper.

>> If you want Sphinx from a virtual environment, you enter the
>> environment, and run the regular build, with sphinx-build from the PATH
>> that points at the venv.
>
> when you do that, ./scripts/spdxcheck.py breaks, affecting checkpatch.

Then you could turn the whole argument around, and say spdxcheck.py
should jump through venv and dependency hoops instead of the docs build.

The point is, it should be the user's responsibility to deal with the
environment and the dependencies.

If they're setting up a virtual environment, and it affects checkpatch,
then they should also include the spdxcheck.py dependencies in the
virtual environment.

This feels like reinventing pipx in a Sphinx wrapper.

We should *reduce* the complexity, not increase it.

>> We don't do this kind of extra magic for any other tools, I honestly
>> don't understand why we'd do this for Sphinx. This just adds complexity
>> for no good reason.
>
>> >
>> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> > ---
>> >  tools/docs/sphinx-build-wrapper | 30 +++++++++++++++++++++++++++---
>> >  1 file changed, 27 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
>> > index ea9f8e17b0bc..cf7b30bc40ff 100755
>> > --- a/tools/docs/sphinx-build-wrapper
>> > +++ b/tools/docs/sphinx-build-wrapper
>> > @@ -63,6 +63,7 @@ from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
>> >  #
>> >  #  Some constants
>> >  #
>> > +VENV_DEFAULT = "sphinx_latest"
>> >  MIN_PYTHON_VERSION = PythonVersion("3.7").version
>> >  PAPER = ["", "a4", "letter"]
>> >  
>> > @@ -119,8 +120,9 @@ class SphinxBuilder:
>> >  
>> >          return path
>> >  
>> > -    def __init__(self, builddir, verbose=False, n_jobs=None):
>> > +    def __init__(self, builddir, venv=None, verbose=False, n_jobs=None):
>> >          """Initialize internal variables"""
>> > +        self.venv = venv
>> >          self.verbose = None
>> >  
>> >          #
>> > @@ -195,6 +197,21 @@ class SphinxBuilder:
>> >  
>> >          self.env = os.environ.copy()
>> >  
>> > +        #
>> > +        # If venv command line argument is specified, run Sphinx from venv
>> > +        #
>> > +        if venv:
>> > +            bin_dir = os.path.join(venv, "bin")
>> > +            if not os.path.isfile(os.path.join(bin_dir, "activate")):
>> > +                sys.exit(f"Venv {venv} not found.")
>> > +
>> > +            # "activate" virtual env
>> > +            self.env["PATH"] = bin_dir + ":" + self.env["PATH"]
>> > +            self.env["VIRTUAL_ENV"] = venv
>> > +            if "PYTHONHOME" in self.env:
>> > +                del self.env["PYTHONHOME"]
>> > +            print(f"Setting venv to {venv}")
>> > +
>> >      def run_sphinx(self, sphinx_build, build_args, *args, **pwargs):
>> >          """
>> >          Executes sphinx-build using current python3 command and setting
>> > @@ -209,7 +226,10 @@ class SphinxBuilder:
>> >  
>> >              cmd = []
>> >  
>> > -            cmd.append(sys.executable)
>> > +            if self.venv:
>> > +                cmd.append("python")
>> > +            else:
>> > +                cmd.append(sys.executable)
>> >  
>> >              cmd.append(sphinx_build)
>> >  
>> > @@ -533,11 +553,15 @@ def main():
>> >      parser.add_argument('-j', '--jobs', type=jobs_type,
>> >                          help="Sets number of jobs to use with sphinx-build")
>> >  
>> > +    parser.add_argument("-V", "--venv", nargs='?', const=f'{VENV_DEFAULT}',
>> > +                        default=None,
>> > +                        help=f'If used, run Sphinx from a venv dir (default dir: {VENV_DEFAULT})')
>> > +
>> >      args = parser.parse_args()
>> >  
>> >      PythonVersion.check_python(MIN_PYTHON_VERSION)
>> >  
>> > -    builder = SphinxBuilder(builddir=args.builddir,
>> > +    builder = SphinxBuilder(builddir=args.builddir, venv=args.venv,
>> >                              verbose=args.verbose, n_jobs=args.jobs)
>> >  
>> >      builder.build(args.target, sphinxdirs=args.sphinxdirs, conf=args.conf,  
>> 
>
>
>
> Thanks,
> Mauro
>

-- 
Jani Nikula, Intel

