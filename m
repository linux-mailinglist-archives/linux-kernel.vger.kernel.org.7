Return-Path: <linux-kernel+bounces-807367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE5B4A379
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8E716DFDF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08D305976;
	Tue,  9 Sep 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubCzsdxx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040E1F30A4;
	Tue,  9 Sep 2025 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402845; cv=none; b=qz6DQmZQS9/lHDPSIXFjjue41DYdYa+rHSHsL6xZuEnc1GLzdzU5yNc0QfLi2oyt7e/tQ6Fx9dhh/JhK7LvodNU+CF7j/exHCn+T+00pSiTykZndabqH3ZEnEH5Q1Bbtqst+i4MqKf5PeL8mFNptBu7R63Z6Hcq+0M/gw7NjUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402845; c=relaxed/simple;
	bh=I/Q1Ax5c1wQTpMhuYDt7fD8nZ37iGWNXzYylEwq5gjs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=cU2ouFYcjBLavtHTxAa43trCLBPM25N9V1LKBLyZhr8QLovYR9va3VEUMkHc5bxzl4oJg4/kQQN58HiPb+SHEAA1jHhr0ZSkn8bjlPEMmR506xnAWKZmsSQ90j4PLclRrQlAp+oEqLkdVJRl8yxUih5+lKQWbfQJFAehdWLZcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ubCzsdxx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KT+YpU8BD12q5IWd/R6k5WcbvOYLYBwR0Ioh/tGh6vA=; b=ubCzsdxxbLdFE/UqCJD8PNAFJl
	0dQCbiPpxgc+eme/EFm+cM2ag7j6rJ+fZjhpVnURf9fyMoYN+/Up0GhNKrXuPB6COJs8bZNY+jEpk
	QBHNkG+BnSybQKmFGof9oESOAgH5YMr3kgSK7Sa9o5zgy9WCHbiRAZSlfk6TzQujcRUsD538lu2U1
	W0xUIoGHiLFFWvkW8IpwEW+rfOGhY58/g01qJzNgflNX9X1zrz8sfAPNGZFR2gDgHkUX0QaSXquOm
	4BEMmzMlPvSmN8RGFY/XQmfdOghUMkUduI8sVOAyUOfeCCXTq8uutxUYxGQCWYbsrfPpcdy8Q/zAR
	H8U0hk4g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsl7-000000059Z5-0qmx;
	Tue, 09 Sep 2025 07:27:21 +0000
Content-Type: multipart/mixed; boundary="------------BiD645pp0mAMW6GmujFBc40N"
Message-ID: <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
Date: Tue, 9 Sep 2025 00:27:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>

This is a multi-part message in MIME format.
--------------BiD645pp0mAMW6GmujFBc40N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

I have a few patch nits below, then some testing info.


On 9/7/25 9:22 AM, Mauro Carvalho Chehab wrote:
> Specially on kAPI, sometimes it is desirable to be able to
> describe global variables that are part of kAPI.
> 
> Documenting vars with Sphinx is simple, as we don't need
> to parse a data struct. All we need is the variable
> declaration and use natice C domain ::c:var: to format it
> for us.
> 
> Add support for it.
> 
> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index 1eca9a918558..405a5c407522 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -199,6 +199,10 @@ class OutputFormat:
>              self.out_enum(fname, name, args)
>              return self.data
>  
> +        if dtype == "global":
> +            self.out_global(fname, name, args)
> +            return self.data
> +
>          if dtype == "typedef":
>              self.out_typedef(fname, name, args)
>              return self.data
> @@ -227,6 +231,9 @@ class OutputFormat:
>      def out_enum(self, fname, name, args):
>          """Outputs an enum"""
>  
> +    def out_global(self, fname, name, args):
> +        """Outputs a global variable"""
> +
>      def out_typedef(self, fname, name, args):
>          """Outputs a typedef"""
>  
> @@ -472,6 +479,18 @@ class RestFormat(OutputFormat):
>          self.lineprefix = oldprefix
>          self.out_section(args)
>  
> +    def out_global(self, fname, name, args):
> +        oldprefix = self.lineprefix
> +        ln = args.declaration_start_line
> +        prototype = args.other_stuff["var_type"]
> +
> +        self.data += f"
> 
> .. c:var:: {prototype}
> 
> "

Are the 5 lines above supposed to be on one line?  Did git send-email split that up for you?
There are a few others like this below.
patch(1) complains when I try to apply the patch from this email.

> +
> +        self.print_lineno(ln)
> +        self.lineprefix = "  "
> +        self.output_highlight(args.get('purpose', ''))
> +        self.data += "
> "
> +
>      def out_typedef(self, fname, name, args):
>  
>          oldprefix = self.lineprefix
> @@ -772,6 +791,18 @@ class ManFormat(OutputFormat):
>              self.data += f'.SH "{section}"' + "
> "
>              self.output_highlight(text)
>  
> +    def out_global(self, fname, name, args):
> +        out_name = self.arg_name(args, name)
> +        prototype = args.other_stuff["var_type"]
> +
> +        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "
> "
> +
> +        self.data += ".SH NAME
> "
> +        self.data += f"{prototype} \- {args['purpose']}

Python complains about the "\-" above. Other places nearby use "\\-"
so I changed it to that instead. Hope that's OK.

> "
> +
> +        self.data += ".SH SYNOPSIS
> "
> +        self.data += f"enum {name}" + " {
> "
> +
>      def out_typedef(self, fname, name, args):
>          module = self.modulename
>          purpose = args.get('purpose')
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 574972e1f741..e2a3f4574894 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -64,7 +64,7 @@ type_param = KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
>  # Tests for the beginning of a kerneldoc block in its various forms.
>  #
>  doc_block = doc_com + KernRe(r'DOC:\s*(.*)?', cache=False)
> -doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\s*(\w*)", cache = False)
> +doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|global)\s*(\w*)", cache = False)
>  doc_begin_func = KernRe(str(doc_com) +			# initial " * '
>                          r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
>                          r'(?:define\s+)?' + 		# possible "define" (not captured)
> @@ -886,6 +886,27 @@ class KernelDoc:
>          self.output_declaration('enum', declaration_name,
>                                  purpose=self.entry.declaration_purpose)
>  
> +    def dump_global(self, ln, proto):
> +        """
> +        Stores global variables that are part of kAPI.
> +        """
> +        VAR_ATTRIBS = [
> +            "extern",
> +        ]
> +        OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
> +
> +        r= KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;(?:#.*)?$")
> +        if not r.match(proto):
> +           self.emit_msg(ln,f"{proto}: can't parse variable")
> +           return
> +
> +        declaration_name = r.group(2)
> +        var_type = r.group(0)
> +
> +        self.output_declaration("global", declaration_name,
> +                                var_type=var_type,
> +                                purpose=self.entry.declaration_purpose)
> +
>      def dump_declaration(self, ln, prototype):
>          """
>          Stores a data declaration inside self.entries array.
> @@ -897,6 +918,8 @@ class KernelDoc:
>              self.dump_typedef(ln, prototype)
>          elif self.entry.decl_type in ["union", "struct"]:
>              self.dump_struct(ln, prototype)
> +        elif self.entry.decl_type == "global":
> +            self.dump_global(ln, prototype)
>          else:
>              # This would be a bug
>              self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')
So, I grabbed some global data from 6-8 places in the kernel and put them intoinit/kdoc-globals-test.c. Then I modified Documentation/core-api/kernel-api.rst
like this at the end of that file:

+
+Kernel Globals
+==========================
+
+.. kernel-doc:: init/kdoc-globals-test.c
+   :identifiers:

The html output says
"Kernel Globals"
but nothing else.

My test files are attached. I dumbed down (simplified) a few
of the globals from fancy types to just unsigned long, but that
didn't help the output results any.

What's happening?
Thanks.

-- 
~Randy

--------------BiD645pp0mAMW6GmujFBc40N
Content-Type: text/x-patch; charset=UTF-8; name="kdoc-globals-test.patch"
Content-Disposition: attachment; filename="kdoc-globals-test.patch"
Content-Transfer-Encoding: base64

LS0tCiBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL2tlcm5lbC1hcGkucnN0IHwgICAgNiArCiBp
bml0L2tkb2MtZ2xvYmFscy10ZXN0LmMgICAgICAgICAgICAgIHwgICA5NiArKysrKysrKysr
KysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMoKykKCi0t
LSAvZGV2L251bGwKKysrIGxpbnV4LW5leHQtMjAyNTA5MDgvaW5pdC9rZG9jLWdsb2JhbHMt
dGVzdC5jCkBAIC0wLDAgKzEsOTYgQEAKKy8vIGtkb2MtZ2xvYmFscy10ZXN0LmM6CisvLyB0
ZXN0IGtlcm5lbC1kb2MgImdsb2JhbCIga2V5d29yZC4KKworLy8gZnJvbSBpbml0L2RvX21v
dW50cy5jOgorLyoqCisgKiBnbG9iYWwgUk9PVF9ERVYgLSBzeXN0ZW0gcm9vdCBkZXZpY2UK
KyAqCisgKiBAUk9PVF9ERVYgaXMgZWl0aGVyIHRoZSBzdWNjZXNzZnVsIHJvb3QgZGV2aWNl
IG9yIHRoZSByb290IGRldmljZQorICogdGhhdCBmYWlsZWQgYm9vdCBpbiB0aGUgYm9vdCBm
YWlsdXJlIG1lc3NhZ2UuCisgKi8KK3Vuc2lnbmVkIGxvbmcgUk9PVF9ERVY7CisvL2Rldl90
IFJPT1RfREVWOworCisvLyBmcm9tIGluaXQvbWFpbi5jOgorLyoqCisgKiBnbG9iYWwgc3lz
dGVtX3N0YXRlIC0gc3lzdGVtIHN0YXRlIHVzZWQgZHVyaW5nIGJvb3Qgb3Igc3VzcGVuZC9o
aWJlcm5hdGUvcmVzdW1lCisgKgorICogQHN5c3RlbV9zdGF0ZSBjYW4gYmUgdXNlZCBkdXJp
bmcgYm9vdCB0byBkZXRlcm1pbmUgaWYgaXQgaXMgc2FmZSB0bworICogbWFrZSBjZXJ0YWlu
IGNhbGxzIHRvIG90aGVyIHBhcnRzIG9mIHRoZSBrZXJuZWwuIEl0IGNhbiBhbHNvIGJlIHVz
ZWQKKyAqIGR1cmluZyBzdXNwZW5kL2hpYmVybmF0ZSBvciByZXN1bWUgdG8gZGV0ZXJtaW5l
IHRoZSBvcmRlciBvZiBhY3Rpb25zCisgKiB0aGF0IG5lZWQgdG8gYmUgZXhlY3V0ZWQuIFRo
ZSBudW1lcmljYWwgdmFsdWVzIG9mIHN5c3RlbV9zdGF0ZSBhcmUKKyAqIHNvbWV0aW1lcyB1
c2VkIGluIG51bWVyaWNhbCBvcmRlcmluZyB0ZXN0cywgc28gdGhlIHJlbGF0aXZlIHZhbHVl
cworICogbXVzdCBub3QgYmUgYWx0ZXJlZC4KKyAqLworZW51bSBzeXN0ZW1fc3RhdGVzIHN5
c3RlbV9zdGF0ZSBfX3JlYWRfbW9zdGx5OworCisvKioKKyAqIGdsb2JhbCBzYXZlZF9jb21t
YW5kX2xpbmUgLSBrZXJuZWwncyBjb21tYW5kIGxpbmUsIHNhdmVkIGZyb20gdXNlIGF0Cisg
KiBhbnkgbGF0ZXIgdGltZSBpbiB0aGUga2VybmVsLgorICovCitjaGFyICpzYXZlZF9jb21t
YW5kX2xpbmUgX19yb19hZnRlcl9pbml0OworCisvKioKKyAqIGdsb2JhbCBsb29wX3Blcl9q
aWZmeSAtIGNhbGN1bGF0ZWQgbG9vcCBjb3VudCBuZWVkZWQgdG8gY29uc3VtZSBvbmUgamlm
ZnkKKyAqIG9mIHRpbWUKKyAqLwordW5zaWduZWQgbG9uZyBsb29wc19wZXJfamlmZnkgPSAo
MTw8MTIpOworCisvLyBmcm9tIGluaXQvY2FsaWJyYXRlLmM6CisvKioKKyAqIGdsb2JhbCBw
cmVzZXRfbHBqIC0gbHBqIChsb29wcyBwZXIgamlmZnkpIHZhbHVlIHNldCBmcm9tIGtlcm5l
bAorICogY29tbWFuZCBsaW5lIHVzaW5nICJscGo9VkFMVUUiCisgKgorICogU2VlIERvY3Vt
ZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0ICgibHBqPSIpIGZv
ciBkZXRhaWxzLgorICovCit1bnNpZ25lZCBsb25nIHByZXNldF9scGo7CisKKy8vIGZyb20g
aW5pdC92ZXJzaW9uLmM6CisvKioKKyAqIGdsb2JhbCBsaW51eF9wcm9jX2Jhbm5lciAtIHRl
eHQgdXNlZCBmcm9tIC9wcm9jL3ZlcnNpb24gZmlsZQorICoKKyAqICogZmlyc3QgJXMgaXMg
c3lzbmFtZSAoZS5nLiwgIkxpbnV4IikKKyAqICogc2Vjb25kICVzIGlzIHJlbGVhc2UKKyAq
ICogdGhpcmQgJXMgaXMgdmVyc2lvbgorICovCitjaGFyIGxpbnV4X3Byb2NfYmFubmVyW107
CisjaWYgMAorY29uc3QgY2hhciBsaW51eF9wcm9jX2Jhbm5lcltdID0KKwkiJXMgdmVyc2lv
biAlcyIKKwkiICgiIExJTlVYX0NPTVBJTEVfQlkgIkAiIExJTlVYX0NPTVBJTEVfSE9TVCAi
KSIKKwkiICgiIExJTlVYX0NPTVBJTEVSICIpICVzXG4iOworI2VuZGlmCisKKy8vIGZyb20g
aW5pdC92ZXJzaW9uLXRpbWVzdGFtcC5jOgorLyoqCisgKiBnbG9iYWwgbGludXhfYmFubmVy
IC0gTGludXggYm9vdCBiYW5uZXIsIHVzdWFsbHkgcHJpbnRlZCBhdCBib290IHRpbWUKKyAq
LworY29uc3QgY2hhciBsaW51eF9iYW5uZXJbXTsKKyNpZiAwCitjb25zdCBjaGFyIGxpbnV4
X2Jhbm5lcltdID0KKwkiTGludXggdmVyc2lvbiAiIFVUU19SRUxFQVNFICIgKCIgTElOVVhf
Q09NUElMRV9CWSAiQCIKKwlMSU5VWF9DT01QSUxFX0hPU1QgIikgKCIgTElOVVhfQ09NUElM
RVIgIikgIiBVVFNfVkVSU0lPTiAiXG4iOworI2VuZGlmCisKKy8vIGZyb20gYmxvY2svZ2Vu
aGQuYzoKKy8qKgorICogZ2xvYmFsIGRpc2tzZXEgLSB1bmlxdWUgc2VxdWVuY2UgbnVtYmVy
IGZvciBibG9jayBkZXZpY2UgaW5zdGFuY2VzCisgKgorICogQWxsb3dzIHVzZXJzcGFjZSB0
byBhc3NvY2lhdGUgdWV2ZW50cyB0byB0aGUgbGlmZXRpbWUgb2YgYSBkZXZpY2UKKyAqLwor
c3RhdGljIGF0b21pYzY0X3QgZGlza3NlcTsKKworLy8gZnJvbSBuZXQvY29yZS9ydG5ldGxp
bmsuYzoKKy8qKgorICogZ2xvYmFsIHJ0bmxfbXV0ZXggLSBoaXN0b3JpY2FsIGdsb2JhbCBs
b2NrIGZvciBuZXR3b3JraW5nIGNvbnRyb2wgb3BlcmF0aW9ucy4KKyAqCisgKiBAcnRubF9t
dXRleCBpcyB1c2VkIHRvIHNlcmlhbGl6ZSBydG5ldGxpbmsgcmVxdWVzdHMKKyAqIGFuZCBw
cm90ZWN0IGFsbCBrZXJuZWwgaW50ZXJuYWwgZGF0YSBzdHJ1Y3R1cmVzIHJlbGF0ZWQgdG8g
bmV0d29ya2luZy4KKyAqCisgKiBTZWUgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL25ldGRl
dmljZXMucnN0IGZvciBkZXRhaWxzLgorICogT2Z0ZW4ga25vd24gYXMgdGhlIHJ0bmxfbG9j
aywgYWx0aG91Z2ggcnRubF9sb2NrIGlzIGEga2VybmVsIGZ1bmN0aW9uLgorICovCit1bnNp
Z25lZCBsb25nIHJ0bmxfbXV0ZXg7CisvL3N0YXRpYyBERUZJTkVfTVVURVgocnRubF9tdXRl
eCk7CisKKy8vIGVuZCB0ZXN0LgotLS0gbGludXgtbmV4dC0yMDI1MDkwOC5vcmlnL0RvY3Vt
ZW50YXRpb24vY29yZS1hcGkva2VybmVsLWFwaS5yc3QKKysrIGxpbnV4LW5leHQtMjAyNTA5
MDgvRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9rZXJuZWwtYXBpLnJzdApAQCAtNDI4LDMgKzQy
OCw5IEBAIFJlYWQtQ29weSBVcGRhdGUgKFJDVSkKIC4uIGtlcm5lbC1kb2M6OiBpbmNsdWRl
L2xpbnV4L3JjdXJlZi5oCiAKIC4uIGtlcm5lbC1kb2M6OiBpbmNsdWRlL2xpbnV4L3JjdXRy
ZWUuaAorCitLZXJuZWwgR2xvYmFscworPT09PT09PT09PT09PT09PT09PT09PT09PT0KKwor
Li4ga2VybmVsLWRvYzo6IGluaXQva2RvYy1nbG9iYWxzLXRlc3QuYworICAgOmlkZW50aWZp
ZXJzOgo=

--------------BiD645pp0mAMW6GmujFBc40N--

