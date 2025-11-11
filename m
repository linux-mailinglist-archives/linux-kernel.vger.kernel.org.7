Return-Path: <linux-kernel+bounces-895808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D19C4EFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596B33B31E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB32136CDFC;
	Tue, 11 Nov 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV5ZTDsM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF9312834;
	Tue, 11 Nov 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877871; cv=none; b=YVvtQD3uyGEyfLCbNJkV5Eng5Q0sHhldNSYZFne6Ysuc4xQoRsCoH12AVeiCE6Bs5BSX3HtICAtF0O3IF4W0f8KbIf9QLU9eE2QJeSyNhjGzSuIdGajLzjVY6UyRRfszZeOsjEADVkC+J164HJD0fkgV5cSowFjiXoXrjwSNDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877871; c=relaxed/simple;
	bh=/ce+erBMqRCE86INMo2fL5/a2bsWquAjgmO83awMm2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+kdcG6R64tz/CWfvSSC5uWQCubAc3TID2/3Qy+phrIMlIBMzV1J9k/nzusSYVGaV81EMTkyKLWyV1owqaEkiiKHqfwCRMKKSp9Fi75MTSRehaVVaQ75P+yoS8zNP8x4dxcyGLl2UMbkJNlBAFkYkMdaGMIcI3ZC/J3IHAOVwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV5ZTDsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DD9C19422;
	Tue, 11 Nov 2025 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877870;
	bh=/ce+erBMqRCE86INMo2fL5/a2bsWquAjgmO83awMm2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fV5ZTDsMiSqHUbDMXkUWUzeaChagY2kOpq+bpxz4QnoHWjbvVh8TbknueEOKTJpti
	 38j07KXkgY36D+PBbSaMeYfIJmW3X/CkBdlV5fwGhGfrLjPgUcAulIs85WMSnKJ2qB
	 qmH7+ARpTtFBbBnRr4e9x49Pv8guubzej4YcClbEd+irOLPW7WQ/1Cf9OmeAtTWUb9
	 iVIg1zjiu2QZIGDfurspujd/v6ufhb+gLhwoGLx2e006D+lMSM+UOl2mw0HST6FjB5
	 6xkCnyx1zfhjZFFml3HecR9LQyKnyLC0TcFyxb2n3yytP02LVz9ylDdea10b6rIIQB
	 hcRzkIXU2fCjw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vIr40-00000007s4d-1VY7;
	Tue, 11 Nov 2025 17:17:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tools/docs/get_feat.py: convert get_feat.pl to Python
Date: Tue, 11 Nov 2025 17:17:42 +0100
Message-ID: <df429e1116744d2faa0a3200ee354a689dfd8b7d.1762877066.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762877066.git.mchehab+huawei@kernel.org>
References: <cover.1762877066.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we want to call Python code directly at the Sphinx extension,
convert get_feat.pl to Python.

The code was made to be (almost) bug-compatible with the Perl
version, with two exceptions:

1. Currently, Perl script outputs a wrong table if arch is set
   to a non-existing value;

2. the ReST table output when --feat is used without --arch
   has an invalid format, as the number of characters for the
   table delimiters are wrong.

Those two bugs were fixed while testing the conversion.

Additionally, another caveat was solved:
the output when --feat is used without arch and the feature
doesn't exist doesn't contain an empty table anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_feat.py |   5 +
 tools/docs/get_feat.py              | 225 +++++++++++++
 tools/docs/lib/parse_features.py    | 494 ++++++++++++++++++++++++++++
 3 files changed, 724 insertions(+)
 create mode 100755 tools/docs/get_feat.py
 create mode 100755 tools/docs/lib/parse_features.py

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 81c67ef23d8d..1dcbfe335a65 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -42,6 +42,11 @@ from docutils.statemachine import ViewList
 from docutils.parsers.rst import directives, Directive
 from sphinx.util.docutils import switch_source_input
 
+srctree = os.path.abspath(os.environ["srctree"])
+sys.path.insert(0, os.path.join(srctree, "tools/docs/lib"))
+
+from parse_features import ParseFeature                # pylint: disable=C0413
+
 def ErrorString(exc):  # Shamelessly stolen from docutils
     return f'{exc.__class__.__name}: {exc}'
 
diff --git a/tools/docs/get_feat.py b/tools/docs/get_feat.py
new file mode 100755
index 000000000000..91f9abe246cf
--- /dev/null
+++ b/tools/docs/get_feat.py
@@ -0,0 +1,225 @@
+#!/usr/bin/env python3
+# pylint: disable=R0902,R0911,R0912,R0914,R0915
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# SPDX-License-Identifier: GPL-2.0
+
+
+"""
+Parse the Linux Feature files and produce a ReST book.
+"""
+
+import argparse
+import os
+import subprocess
+import sys
+
+from pprint import pprint
+
+LIB_DIR = "lib"
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
+
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
+
+from parse_features import ParseFeature                # pylint: disable=C0413
+
+SRCTREE = os.path.join(os.path.dirname(os.path.realpath(__file__)), "../..")
+DEFAULT_DIR = "Documentation/features"
+
+
+class GetFeature:
+    """Helper class to parse feature parsing parameters"""
+
+    @staticmethod
+    def get_current_arch():
+        """Detects the current architecture"""
+
+        proc = subprocess.run(["uname", "-m"], check=True,
+                              capture_output=True, text=True)
+
+        arch = proc.stdout.strip()
+        if arch in ["x86_64", "i386"]:
+            arch = "x86"
+        elif arch == "s390x":
+            arch = "s390"
+
+        return arch
+
+    def run_parser(self, args):
+        """Execute the feature parser"""
+
+        feat = ParseFeature(args.directory, args.debug, args.enable_fname)
+        data = feat.parse()
+
+        if args.debug > 2:
+            pprint(data)
+
+        return feat
+
+    def run_rest(self, args):
+        """
+        Generate tables in ReST format. Three types of tables are
+        supported, depending on the calling arguments:
+
+        - neither feature nor arch is passed: generates a full matrix;
+        - arch provided: generates a table of supported tables for the
+          guiven architecture, eventually filtered by feature;
+        - only feature provided: generates a table with feature details,
+          showing what architectures it is implemented.
+        """
+
+        feat = self.run_parser(args)
+
+        if args.arch:
+            rst = feat.output_arch_table(args.arch, args.feat)
+        elif args.feat:
+            rst = feat.output_feature(args.feat)
+        else:
+            rst = feat.output_matrix()
+
+        print(rst)
+
+    def run_current(self, args):
+        """
+        Instead of using a --arch parameter, get feature for the current
+        architecture.
+        """
+
+        args.arch = self.get_current_arch()
+
+        self.run_rest(args)
+
+    def run_list(self, args):
+        """
+        Generate a list of features for a given architecture, in a format
+        parseable by other scripts. The output format is not ReST.
+        """
+
+        if not args.arch:
+            args.arch = self.get_current_arch()
+
+        feat = self.run_parser(args)
+        msg = feat.list_arch_features(args.arch, args.feat)
+
+        print(msg)
+
+    def parse_arch(self, parser):
+        """Add a --arch parsing argument"""
+
+        parser.add_argument("--arch",
+                            help="Output features for an specific"
+                                 " architecture, optionally filtering for a "
+                                 "single specific feature.")
+
+    def parse_feat(self, parser):
+        """Add a --feat parsing argument"""
+
+        parser.add_argument("--feat", "--feature",
+                            help="Output features for a single specific "
+                                  "feature.")
+
+
+    def current_args(self, subparsers):
+        """Implementscurrent argparse subparser"""
+
+        parser = subparsers.add_parser("current",
+                                       formatter_class=argparse.RawTextHelpFormatter,
+                                       description="Output table in ReST "
+                                                   "compatible ASCII format "
+                                                   "with features for this "
+                                                   "machine's architecture")
+
+        self.parse_feat(parser)
+        parser.set_defaults(func=self.run_current)
+
+    def rest_args(self, subparsers):
+        """Implement rest argparse subparser"""
+
+        parser = subparsers.add_parser("rest",
+                                       formatter_class=argparse.RawTextHelpFormatter,
+                                       description="Output table(s) in ReST "
+                                                   "compatible ASCII format "
+                                                   "with features in ReST "
+                                                   "markup language. The "
+                                                   "output is affected by "
+                                                   "--arch or --feat/--feature"
+                                                   " flags.")
+
+        self.parse_arch(parser)
+        self.parse_feat(parser)
+        parser.set_defaults(func=self.run_rest)
+
+    def list_args(self, subparsers):
+        """Implement list argparse subparser"""
+
+        parser = subparsers.add_parser("list",
+                                       formatter_class=argparse.RawTextHelpFormatter,
+                                       description="List features for this "
+                                                   "machine's architecture, "
+                                                   "using an easier to parse "
+                                                   "format. The output is "
+                                                   "affected by --arch flag.")
+
+        self.parse_arch(parser)
+        self.parse_feat(parser)
+        parser.set_defaults(func=self.run_list)
+
+    def validate_args(self, subparsers):
+        """Implement validate argparse subparser"""
+
+        parser = subparsers.add_parser("validate",
+                                       formatter_class=argparse.RawTextHelpFormatter,
+                                       description="Validate the contents of "
+                                                   "the files under "
+                                                   f"{DEFAULT_DIR}.")
+
+        parser.set_defaults(func=self.run_parser)
+
+    def parser(self):
+        """
+        Create an arparse with common options and several subparsers
+        """
+        parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter)
+
+        parser.add_argument("-d", "--debug", action="count", default=0,
+                            help="Put the script in verbose mode, useful for "
+                                 "debugging. Can be called multiple times, to "
+                                 "increase verbosity.")
+
+        parser.add_argument("--directory", "--dir", default=DEFAULT_DIR,
+                            help="Changes the location of the Feature files. "
+                                 f"By default, it uses the {DEFAULT_DIR} "
+                                 "directory.")
+
+        parser.add_argument("--enable-fname", action="store_true",
+                            help="Prints the file name of the feature files. "
+                                 "This can be used in order to track "
+                                 "dependencies during documentation build.")
+
+        subparsers = parser.add_subparsers()
+
+        self.current_args(subparsers)
+        self.rest_args(subparsers)
+        self.list_args(subparsers)
+        self.validate_args(subparsers)
+
+        args = parser.parse_args()
+
+        return args
+
+
+def main():
+    """Main program"""
+
+    feat = GetFeature()
+
+    args = feat.parser()
+
+    if "func" in args:
+        args.func(args)
+    else:
+        sys.exit(f"Please specify a valid command for {sys.argv[0]}")
+
+
+# Call main method
+if __name__ == "__main__":
+    main()
diff --git a/tools/docs/lib/parse_features.py b/tools/docs/lib/parse_features.py
new file mode 100755
index 000000000000..b88c04d3e2fe
--- /dev/null
+++ b/tools/docs/lib/parse_features.py
@@ -0,0 +1,494 @@
+#!/usr/bin/env python3
+# pylint: disable=R0902,R0911,R0912,R0914,R0915
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+# SPDX-License-Identifier: GPL-2.0
+
+
+"""
+Library to parse the Linux Feature files and produce a ReST book.
+"""
+
+import os
+import re
+import sys
+
+from glob import iglob
+
+
+class ParseFeature:
+    """
+    Parses Documentation/features, allowing to generate ReST documentation
+    from it.
+    """
+
+    h_name = "Feature"
+    h_kconfig = "Kconfig"
+    h_description = "Description"
+    h_subsys = "Subsystem"
+    h_status = "Status"
+    h_arch = "Architecture"
+
+    # Sort order for status. Others will be mapped at the end.
+    status_map = {
+        "ok":   0,
+        "TODO": 1,
+        "N/A":  2,
+        # The only missing status is "..", which was mapped as "---",
+        # as this is an special ReST cell value. Let it get the
+        # default order (99).
+    }
+
+    def __init__(self, prefix, debug=0, enable_fname=False):
+        """
+        Sets internal variables
+        """
+
+        self.prefix = prefix
+        self.debug = debug
+        self.enable_fname = enable_fname
+
+        self.data = {}
+
+        # Initial maximum values use just the headers
+        self.max_size_name = len(self.h_name)
+        self.max_size_kconfig = len(self.h_kconfig)
+        self.max_size_description = len(self.h_description)
+        self.max_size_desc_word = 0
+        self.max_size_subsys = len(self.h_subsys)
+        self.max_size_status = len(self.h_status)
+        self.max_size_arch = len(self.h_arch)
+        self.max_size_arch_with_header = self.max_size_arch + self.max_size_arch
+        self.description_size = 1
+
+        self.msg = ""
+
+    def emit(self, msg="", end="\n"):
+        self.msg += msg + end
+
+    def parse_error(self, fname, ln, msg, data=None):
+        """
+        Displays an error message, printing file name and line
+        """
+
+        if ln:
+            fname += f"#{ln}"
+
+        print(f"Warning: file {fname}: {msg}", file=sys.stderr, end="")
+
+        if data:
+            data = data.rstrip()
+            print(f":\n\t{data}", file=sys.stderr)
+        else:
+            print("", file=sys.stderr)
+
+    def parse_feat_file(self, fname):
+        """Parses a single arch-support.txt feature file"""
+
+        if os.path.isdir(fname):
+            return
+
+        base = os.path.basename(fname)
+
+        if base != "arch-support.txt":
+            if self.debug:
+                print(f"ignoring {fname}", file=sys.stderr)
+            return
+
+        subsys = os.path.dirname(fname).split("/")[-2]
+        self.max_size_subsys = max(self.max_size_subsys, len(subsys))
+
+        feature_name = ""
+        kconfig = ""
+        description = ""
+        comments = ""
+        arch_table = {}
+
+        if self.debug > 1:
+            print(f"Opening {fname}", file=sys.stderr)
+
+        if self.enable_fname:
+            full_fname = os.path.abspath(fname)
+            self.emit(f".. FILE {full_fname}")
+
+        with open(fname, encoding="utf-8") as f:
+            for ln, line in enumerate(f, start=1):
+                line = line.strip()
+
+                match = re.match(r"^\#\s+Feature\s+name:\s*(.*\S)", line)
+                if match:
+                    feature_name = match.group(1)
+
+                    self.max_size_name = max(self.max_size_name,
+                                             len(feature_name))
+                    continue
+
+                match = re.match(r"^\#\s+Kconfig:\s*(.*\S)", line)
+                if match:
+                    kconfig = match.group(1)
+
+                    self.max_size_kconfig = max(self.max_size_kconfig,
+                                                len(kconfig))
+                    continue
+
+                match = re.match(r"^\#\s+description:\s*(.*\S)", line)
+                if match:
+                    description = match.group(1)
+
+                    self.max_size_description = max(self.max_size_description,
+                                                    len(description))
+
+                    words = re.split(r"\s+", line)[1:]
+                    for word in words:
+                        self.max_size_desc_word = max(self.max_size_desc_word,
+                                                        len(word))
+
+                    continue
+
+                if re.search(r"^\\s*$", line):
+                    continue
+
+                if re.match(r"^\s*\-+\s*$", line):
+                    continue
+
+                if re.search(r"^\s*\|\s*arch\s*\|\s*status\s*\|\s*$", line):
+                    continue
+
+                match = re.match(r"^\#\s*(.*)$", line)
+                if match:
+                    comments += match.group(1)
+                    continue
+
+                match = re.match(r"^\s*\|\s*(\S+):\s*\|\s*(\S+)\s*\|\s*$", line)
+                if match:
+                    arch = match.group(1)
+                    status = match.group(2)
+
+                    self.max_size_status = max(self.max_size_status,
+                                               len(status))
+                    self.max_size_arch = max(self.max_size_arch, len(arch))
+
+                    if status == "..":
+                        status = "---"
+
+                    arch_table[arch] = status
+
+                    continue
+
+                self.parse_error(fname, ln, "Line is invalid", line)
+
+        if not feature_name:
+            self.parse_error(fname, 0, "Feature name not found")
+            return
+        if not subsys:
+            self.parse_error(fname, 0, "Subsystem not found")
+            return
+        if not kconfig:
+            self.parse_error(fname, 0, "Kconfig not found")
+            return
+        if not description:
+            self.parse_error(fname, 0, "Description not found")
+            return
+        if not arch_table:
+            self.parse_error(fname, 0, "Architecture table not found")
+            return
+
+        self.data[feature_name] = {
+            "where": fname,
+            "subsys": subsys,
+            "kconfig": kconfig,
+            "description": description,
+            "comments": comments,
+            "table": arch_table,
+        }
+
+        self.max_size_arch_with_header = self.max_size_arch + len(self.h_arch)
+
+    def parse(self):
+        """Parses all arch-support.txt feature files inside self.prefix"""
+
+        path = os.path.expanduser(self.prefix)
+
+        if self.debug > 2:
+            print(f"Running parser for {path}")
+
+        example_path = os.path.join(path, "arch-support.txt")
+
+        for fname in iglob(os.path.join(path, "**"), recursive=True):
+            if fname != example_path:
+                self.parse_feat_file(fname)
+
+        return self.data
+
+    def output_arch_table(self, arch, feat=None):
+        """
+        Output feature(s) for a given architecture.
+        """
+
+        title = f"Feature status on {arch} architecture"
+
+        self.emit("=" * len(title))
+        self.emit(title)
+        self.emit("=" * len(title))
+        self.emit()
+
+        self.emit("=" * self.max_size_subsys + "  ", end="")
+        self.emit("=" * self.max_size_name + "  ", end="")
+        self.emit("=" * self.max_size_kconfig + "  ", end="")
+        self.emit("=" * self.max_size_status + "  ", end="")
+        self.emit("=" * self.max_size_description)
+
+        self.emit(f"{self.h_subsys:<{self.max_size_subsys}}  ", end="")
+        self.emit(f"{self.h_name:<{self.max_size_name}}  ", end="")
+        self.emit(f"{self.h_kconfig:<{self.max_size_kconfig}}  ", end="")
+        self.emit(f"{self.h_status:<{self.max_size_status}}  ", end="")
+        self.emit(f"{self.h_description:<{self.max_size_description}}")
+
+        self.emit("=" * self.max_size_subsys + "  ", end="")
+        self.emit("=" * self.max_size_name + "  ", end="")
+        self.emit("=" * self.max_size_kconfig + "  ", end="")
+        self.emit("=" * self.max_size_status + "  ", end="")
+        self.emit("=" * self.max_size_description)
+
+        sorted_features = sorted(self.data.keys(),
+                                 key=lambda x: (self.data[x]["subsys"],
+                                                x.lower()))
+
+        for name in sorted_features:
+            if feat and name != feat:
+                continue
+
+            arch_table = self.data[name]["table"]
+
+            if not arch in arch_table:
+                continue
+
+            self.emit(f"{self.data[name]['subsys']:<{self.max_size_subsys}}  ",
+                  end="")
+            self.emit(f"{name:<{self.max_size_name}}  ", end="")
+            self.emit(f"{self.data[name]['kconfig']:<{self.max_size_kconfig}}  ",
+                  end="")
+            self.emit(f"{arch_table[arch]:<{self.max_size_status}}  ",
+                  end="")
+            self.emit(f"{self.data[name]['description']}")
+
+        self.emit("=" * self.max_size_subsys + "  ", end="")
+        self.emit("=" * self.max_size_name + "  ", end="")
+        self.emit("=" * self.max_size_kconfig + "  ", end="")
+        self.emit("=" * self.max_size_status + "  ", end="")
+        self.emit("=" * self.max_size_description)
+
+        return self.msg
+
+    def output_feature(self, feat):
+        """
+        Output a feature on all architectures
+        """
+
+        title = f"Feature {feat}"
+
+        self.emit("=" * len(title))
+        self.emit(title)
+        self.emit("=" * len(title))
+        self.emit()
+
+        if not feat in self.data:
+            return
+
+        if self.data[feat]["subsys"]:
+            self.emit(f":Subsystem: {self.data[feat]['subsys']}")
+        if self.data[feat]["kconfig"]:
+            self.emit(f":Kconfig: {self.data[feat]['kconfig']}")
+
+        desc = self.data[feat]["description"]
+        desc = desc[0].upper() + desc[1:]
+        desc = desc.rstrip(". \t")
+        self.emit(f"\n{desc}.\n")
+
+        com = self.data[feat]["comments"].strip()
+        if com:
+            self.emit("Comments")
+            self.emit("--------")
+            self.emit(f"\n{com}\n")
+
+        self.emit("=" * self.max_size_arch + "  ", end="")
+        self.emit("=" * self.max_size_status)
+
+        self.emit(f"{self.h_arch:<{self.max_size_arch}}  ", end="")
+        self.emit(f"{self.h_status:<{self.max_size_status}}")
+
+        self.emit("=" * self.max_size_arch + "  ", end="")
+        self.emit("=" * self.max_size_status)
+
+        arch_table = self.data[feat]["table"]
+        for arch in sorted(arch_table.keys()):
+            self.emit(f"{arch:<{self.max_size_arch}}  ", end="")
+            self.emit(f"{arch_table[arch]:<{self.max_size_status}}")
+
+        self.emit("=" * self.max_size_arch + "  ", end="")
+        self.emit("=" * self.max_size_status)
+
+        return self.msg
+
+    def matrix_lines(self, desc_size, max_size_status, header):
+        """
+        Helper function to split element tables at the output matrix
+        """
+
+        if header:
+            ln_marker = "="
+        else:
+            ln_marker = "-"
+
+        self.emit("+" + ln_marker * self.max_size_name + "+", end="")
+        self.emit(ln_marker * desc_size, end="")
+        self.emit("+" + ln_marker * max_size_status + "+")
+
+    def output_matrix(self):
+        """
+        Generates a set of tables, groped by subsystem, containing
+        what's the feature state on each architecture.
+        """
+
+        title = "Feature status on all architectures"
+
+        self.emit("=" * len(title))
+        self.emit(title)
+        self.emit("=" * len(title))
+        self.emit()
+
+        desc_title = f"{self.h_kconfig} / {self.h_description}"
+
+        desc_size = self.max_size_kconfig + 4
+        if not self.description_size:
+            desc_size = max(self.max_size_description, desc_size)
+        else:
+            desc_size = max(self.description_size, desc_size)
+
+        desc_size = max(self.max_size_desc_word, desc_size, len(desc_title))
+
+        notcompat = "Not compatible"
+        self.max_size_status = max(self.max_size_status, len(notcompat))
+
+        min_status_size = self.max_size_status + self.max_size_arch + 4
+        max_size_status = max(min_status_size, self.max_size_status)
+
+        h_status_per_arch = "Status per architecture"
+        max_size_status = max(max_size_status, len(h_status_per_arch))
+
+        cur_subsys = None
+        for name in sorted(self.data.keys(),
+                           key=lambda x: (self.data[x]["subsys"], x.lower())):
+            if not cur_subsys or cur_subsys != self.data[name]["subsys"]:
+                if cur_subsys:
+                    self.emit()
+
+                cur_subsys = self.data[name]["subsys"]
+
+                title = f"Subsystem: {cur_subsys}"
+                self.emit(title)
+                self.emit("=" * len(title))
+                self.emit()
+
+                self.matrix_lines(desc_size, max_size_status, 0)
+
+                self.emit(f"|{self.h_name:<{self.max_size_name}}", end="")
+                self.emit(f"|{desc_title:<{desc_size}}", end="")
+                self.emit(f"|{h_status_per_arch:<{max_size_status}}|")
+
+                self.matrix_lines(desc_size, max_size_status, 1)
+
+            lines = []
+            descs = []
+            cur_status = ""
+            line = ""
+
+            arch_table = sorted(self.data[name]["table"].items(),
+                                key=lambda x: (self.status_map.get(x[1], 99),
+                                               x[0].lower()))
+
+            for arch, status in arch_table:
+                if status == "---":
+                    status = notcompat
+
+                if status != cur_status:
+                    if line != "":
+                        lines.append(line)
+                        line = ""
+                    line = f"- **{status}**: {arch}"
+                elif len(line) + len(arch) + 2 < max_size_status:
+                    line += f", {arch}"
+                else:
+                    lines.append(line)
+                    line = f"  {arch}"
+                cur_status = status
+
+            if line != "":
+                lines.append(line)
+
+            description = self.data[name]["description"]
+            while len(description) > desc_size:
+                desc_line = description[:desc_size]
+
+                last_space = desc_line.rfind(" ")
+                if last_space != -1:
+                    desc_line = desc_line[:last_space]
+                    descs.append(desc_line)
+                    description = description[last_space + 1:]
+                else:
+                    desc_line = desc_line[:-1]
+                    descs.append(desc_line + "\\")
+                    description = description[len(desc_line):]
+
+            if description:
+                descs.append(description)
+
+            while len(lines) < 2 + len(descs):
+                lines.append("")
+
+            for ln, line in enumerate(lines):
+                col = ["", ""]
+
+                if not ln:
+                    col[0] = name
+                    col[1] = f"``{self.data[name]['kconfig']}``"
+                else:
+                    if ln >= 2 and descs:
+                        col[1] = descs.pop(0)
+
+                self.emit(f"|{col[0]:<{self.max_size_name}}", end="")
+                self.emit(f"|{col[1]:<{desc_size}}", end="")
+                self.emit(f"|{line:<{max_size_status}}|")
+
+            self.matrix_lines(desc_size, max_size_status, 0)
+
+        return self.msg
+
+    def list_arch_features(self, arch, feat):
+        """
+        Print a matrix of kernel feature support for the chosen architecture.
+        """
+        self.emit("#")
+        self.emit(f"# Kernel feature support matrix of the '{arch}' architecture:")
+        self.emit("#")
+
+        # Sort by subsystem, then by feature name (case‑insensitive)
+        for name in sorted(self.data.keys(),
+                           key=lambda n: (self.data[n]["subsys"].lower(),
+                                          n.lower())):
+            if feat and name != feat:
+                continue
+
+            feature = self.data[name]
+            arch_table = feature["table"]
+            status = arch_table.get(arch, "")
+            status = " " * ((4 - len(status)) // 2) + status
+
+            self.emit(f"{feature['subsys']:>{self.max_size_subsys + 1}}/ ",
+                      end="")
+            self.emit(f"{name:<{self.max_size_name}}: ", end="")
+            self.emit(f"{status:<5}|   ", end="")
+            self.emit(f"{feature['kconfig']:>{self.max_size_kconfig}} ",
+                      end="")
+            self.emit(f"#  {feature['description']}")
+
+        return self.msg
-- 
2.51.1


