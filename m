Return-Path: <linux-kernel+bounces-653373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12024ABB82B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 11:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543E73B3583
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D3265CC6;
	Mon, 19 May 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkrcYEj9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AB26A0B3
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645505; cv=none; b=aqsGGKmvaKzZ4SdeegFWDNsK0eaQt4NNe0Av1tLAGP7m8ga924k6FNiz+udNAYTX6IQGSk7fNwekhlDP8JOOuV7/Lwo5pHuiknOgY6zNV4ukRLlWfHCl/mpD7hLw2d5tAiFNOTpp4+3tQLMLp4NGMvWxIwf7zUn99M4cDvBvTUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645505; c=relaxed/simple;
	bh=YjbtpUGlNEv5zF08hpRyZW7vUzTqaWMFJYNJKvujq+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pz7s1bwuUvKZ2EDhdrpPhnOluntBAy9PtUod15Fnwu0quNKBBOi/OqrlD/r7+Q/yxbkOCyc6rRiW9qO4Bl+gKXfRkUROPU9++0Jxzz12vpDpwhzDoTMX+0mF0d+jgDs8XtAVQlArqq7Cy3rf5hXBX1hXbgirS511W0v9+GqY9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkrcYEj9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747645502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YjbtpUGlNEv5zF08hpRyZW7vUzTqaWMFJYNJKvujq+U=;
	b=VkrcYEj9njhMtOBltjcm3e9oDxNhI+debwyvslBl81gZ2KEDnY16FvM4pBfre+t4/IshO7
	QlGi2FikO4F8io1FCcG5MMZJ5pmem59DtK+ZGln0gc9Uddyizl56CGaVEZn2lsCas9f3Hu
	F9sWQ30UWZGh/4lTOG7cEQj68ujPYCM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-LpzqL-VrM9mTiMoDu130fg-1; Mon, 19 May 2025 05:05:01 -0400
X-MC-Unique: LpzqL-VrM9mTiMoDu130fg-1
X-Mimecast-MFC-AGG-ID: LpzqL-VrM9mTiMoDu130fg_1747645500
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so22698525e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 02:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747645500; x=1748250300;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjbtpUGlNEv5zF08hpRyZW7vUzTqaWMFJYNJKvujq+U=;
        b=voZnJyZheYkuLSV21dgVLMnFWAfoteSl6gSZqqKbrc18U50DZKg+Zul64NQd7sQmGf
         OQ4sGURkdcyf7FPgxJmA0V31s3McnsyhXJw99ojw/meEPtHa7B9AuTaF2Ul/wYW8iQ5D
         7Cpu5tYUH4KsTjffLBuGSa2nkptXlTwpFOEIjbuy9vzetO2Vt8ELj1GPO2K//r+y9Pcr
         OBw4vzj56YzXLjxSXkor/+cOkzvbygOlkG0VHdXdEqGM/5eE/9Z0MmlCywAWnT+CRvvU
         DcutUGBtz+FURm6SeX0Kks68C0krhOaYGYf76A6gTXQaS9bexZzYS+zuhls9JtjsRCPv
         8QrA==
X-Gm-Message-State: AOJu0YwHC9nSdFINIHArdlwKl9moRT3XkhlJYTbtEd+3ZhCAGwrlAahv
	oe4Nv2tEs6m3K9KOJn0ZkFTVhU0JOG3Ww0KSCFyC9Fw8KKpeVuq40Oew5CJH6DqkFxKvBwZmJZW
	BfR8B6Tw7vW2wLLzmBI8CI5cdN3eIEV9WMPwmnbLiacewqkxuHch1ZHALfS6ICoc2RYvaCvS3an
	gH
X-Gm-Gg: ASbGncstq34mO6Z0D7mUNm3mMoZfvzQVtil4tyl+ppp7F9lICNbO5UhIdiI5YrxlL95
	X+mLmSVuEEH0HXHBROriSgzPX4+wux3z/PnfaG4Tl9QGCulSc9JLNCk+zrsK1BhYu19W3miUOR1
	8yC4pn4GdV11z6RGqYH9Kt33XcIFpex40BiwfObduCpTiNmKyhOpZdUircRM0HLOw1e6WB4FsKD
	VOlwCtU1vSjpyfeOEYWeLNT7Viq/OPUCXz/2bBGAhgVtym5jRGXGImcA+d6ca+mS1VjhmT7PJyL
	LckMB/JvHsTCn3riHv6zYzk0WfHRo9VvZlGqfQ==
X-Received: by 2002:a05:600c:1f87:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-442ff03281dmr62660885e9.22.1747645500182;
        Mon, 19 May 2025 02:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtHmBiJiIZSAh1CkB/DnMloy3lXPe4XZ0UFDPkqDYHYqqpW0CHXsKxcray4myhNO5vOONyUw==
X-Received: by 2002:a05:600c:1f87:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-442ff03281dmr62660665e9.22.1747645499817;
        Mon, 19 May 2025 02:04:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583fb7sm131633895e9.32.2025.05.19.02.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:04:59 -0700 (PDT)
Message-ID: <2b501844f1a238ef7eb12b98f14db02a64d06226.camel@redhat.com>
Subject: Re: [RFC PATCH v2 07/12] rv: Adapt the sco monitor to the new
 set_state
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Date: Mon, 19 May 2025 11:04:56 +0200
In-Reply-To: <20250519084220.iProU-cg@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
	 <20250514084314.57976-8-gmonaco@redhat.com>
	 <20250519084220.iProU-cg@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CgpPbiBNb24sIDIwMjUtMDUtMTkgYXQgMTA6NDIgKzAyMDAsIE5hbSBDYW8gd3JvdGU6Cj4gT24g
V2VkLCBNYXkgMTQsIDIwMjUgYXQgMTA6NDM6MDlBTSArMDIwMCwgR2FicmllbGUgTW9uYWNvIHdy
b3RlOgo+ID4gwqAJLmZ1bmN0aW9uID0gewo+ID4gLQkJe8KgwqDCoMKgIHRocmVhZF9jb250ZXh0
X3NjbywKPiA+IHNjaGVkdWxpbmdfY29udGV4dF9zY28swqDCoMKgwqDCoMKgwqDCoMKgIElOVkFM
SURfU1RBVEUgfSwKPiA+IC0JCXvCoMKgwqDCoMKgwqDCoMKgwqAgSU5WQUxJRF9TVEFURSzCoMKg
wqDCoMKgwqDCoMKgwqAKPiA+IElOVkFMSURfU1RBVEUswqDCoMKgwqAgdGhyZWFkX2NvbnRleHRf
c2NvIH0sCj4gPiArCQl7wqDCoMKgwqAgdGhyZWFkX2NvbnRleHRfc2NvLMKgwqDCoMKgwqDCoMKg
wqDCoCBJTlZBTElEX1NUQVRFLAo+ID4gc2NoZWR1bGluZ19jb250ZXh0X3NjbyzCoMKgwqDCoMKg
wqDCoMKgwqAgSU5WQUxJRF9TVEFURSB9LAo+ID4gKwkJe8KgwqDCoMKgwqDCoMKgwqDCoCBJTlZB
TElEX1NUQVRFLAo+ID4gc2NoZWR1bGluZ19jb250ZXh0X3NjbyzCoMKgwqDCoMKgwqDCoMKgwqAg
SU5WQUxJRF9TVEFURSzCoMKgwqDCoAo+ID4gdGhyZWFkX2NvbnRleHRfc2NvIH0sCj4gCj4gVGhp
cyBpcyBvdmVyIHRoZSAxMDAgY29sdW1uIGxpbWl0Lgo+IAo+IEkga25vdyBpdCBpcyBub3QgeW91
ciBmYXVsdCwgdGhpcyBpcyBnZW5lcmF0ZWQuIEJhY2sgd2hlbiBJIHdhcwo+IHBsYXlpbmcKPiB3
aXRoIERBIG1vbml0b3IsIEkgbWFkZSBhIHBhdGNoIHRvIGZpeCB0aGlzLiBNYXliZSB5b3UgY291
bGQgaW5jbHVkZQo+IGl0IGluCj4geW91ciBzZXJpZXM/Cj4gCj4gRnJvbSBiNGZiNjQ4Mzk4YTI5
YTljMGQ4ZTA4YmQxMjM5NDk3OGQzOTQ4YTVlIE1vbiBTZXAgMTcgMDA6MDA6MDAKPiAyMDAxCj4g
RnJvbTogTmFtIENhbyA8bmFtY2FvQGxpbnV0cm9uaXguZGU+Cj4gRGF0ZTogRnJpLCAxNSBOb3Yg
MjAyNCAxNDo1NjozMyArMDEwMAo+IFN1YmplY3Q6IFtQQVRDSF0gdG9vbHMvcnYvZG90MmM6IEZp
eCBnZW5lcmF0ZWQgZmlsZXMgZ29pbmcgb3ZlciAxMDAKPiBjb2x1bW4KPiDCoGxpbWl0Cj4gCj4g
VGhlIGRvdDJjLnB5IHNjcmlwdCBnZW5lcmF0ZXMgYWxsIHN0YXRlcyBpbiBhIHNpbmdsZSBsaW5l
LiBUaGlzCj4gYnJlYWtzIHRoZQo+IDEwMCBjb2x1bW4gbGltaXQgd2hlbiB0aGUgc3RhdGUgbWFj
aGluZXMgYXJlIG5vbi10cml2aWFsLgo+IAo+IENoYW5nZSBkb3QyYy5weSB0byBnZW5lcmF0ZSB0
aGUgc3RhdGVzIGluIHNlcGFyYXRlIGxpbmVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE5hbSBDYW8g
PG5hbWNhb0BsaW51dHJvbml4LmRlPgo+IC0tLQo+IMKgdG9vbHMvdmVyaWZpY2F0aW9uL3J2Z2Vu
L3J2Z2VuL2RvdDJjLnB5IHwgMTMgKysrLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Zl
cmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9kb3QyYy5weQo+IGIvdG9vbHMvdmVyaWZpY2F0aW9uL3J2
Z2VuL3J2Z2VuL2RvdDJjLnB5Cj4gaW5kZXggNjAwOWNhZjU2OGQ5Li5hYmMwZWU1NjliMzQgMTAw
NjQ0Cj4gLS0tIGEvdG9vbHMvdmVyaWZpY2F0aW9uL3J2Z2VuL3J2Z2VuL2RvdDJjLnB5Cj4gKysr
IGIvdG9vbHMvdmVyaWZpY2F0aW9uL3J2Z2VuL3J2Z2VuL2RvdDJjLnB5Cj4gQEAgLTE1MiwyOSAr
MTUyLDIyIEBAIGNsYXNzIERvdDJjKEF1dG9tYXRhKToKPiDCoMKgwqDCoMKgwqDCoMKgIG1heF9z
dGF0ZV9uYW1lID0gbWF4KHNlbGYuc3RhdGVzLCBrZXkgPSBsZW4pLl9fbGVuX18oKQo+IMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIG1heChtYXhfc3RhdGVfbmFtZSwgc2VsZi5pbnZhbGlkX3N0YXRl
X3N0ci5fX2xlbl9fKCkpCj4gwqAKPiAtwqDCoMKgIGRlZiBfX2dldF9zdGF0ZV9zdHJpbmdfbGVu
Z3RoKHNlbGYpOgo+IC3CoMKgwqDCoMKgwqDCoCBtYXhsZW4gPSBzZWxmLl9fZ2V0X21heF9zdHJs
ZW5fb2Zfc3RhdGVzKCkgKwo+IHNlbGYuZW51bV9zdWZmaXguX19sZW5fXygpCj4gLcKgwqDCoMKg
wqDCoMKgIHJldHVybiAiJSIgKyBzdHIobWF4bGVuKSArICJzIgo+IC0KPiDCoMKgwqDCoCBkZWYg
Z2V0X2F1dF9pbml0X2Z1bmN0aW9uKHNlbGYpOgo+IMKgwqDCoMKgwqDCoMKgwqAgbnJfc3RhdGVz
ID0gc2VsZi5zdGF0ZXMuX19sZW5fXygpCj4gwqDCoMKgwqDCoMKgwqDCoCBucl9ldmVudHMgPSBz
ZWxmLmV2ZW50cy5fX2xlbl9fKCkKPiDCoMKgwqDCoMKgwqDCoMKgIGJ1ZmYgPSBbXQo+IMKgCj4g
LcKgwqDCoMKgwqDCoMKgIHN0cmZvcm1hdCA9IHNlbGYuX19nZXRfc3RhdGVfc3RyaW5nX2xlbmd0
aCgpCj4gLQo+IMKgwqDCoMKgwqDCoMKgwqAgZm9yIHggaW4gcmFuZ2UobnJfc3RhdGVzKToKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsaW5lID0gIlx0XHR7ICIKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBidWZmLmFwcGVuZCgiXHRcdHsiKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
b3IgeSBpbiByYW5nZShucl9ldmVudHMpOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIG5leHRfc3RhdGUgPSBzZWxmLmZ1bmN0aW9uW3hdW3ldCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgbmV4dF9zdGF0ZSAhPSBzZWxmLmludmFsaWRfc3RhdGVfc3RyOgo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmV4dF9zdGF0ZSA9IHNl
bGYuZnVuY3Rpb25beF1beV0gKwo+IHNlbGYuZW51bV9zdWZmaXgKPiDCoAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIHkgIT0gbnJfZXZlbnRzLTE6Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxpbmUgPSBsaW5lICsgc3RyZm9ybWF0ICUgbmV4
dF9zdGF0ZSArICIsICIKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YnVmZi5hcHBlbmQoJycuam9pbigoIlx0XHRcdCIsIG5leHRfc3RhdGUsCj4gIiwiKSkpCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZToKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbGluZSA9IGxpbmUgKyBzdHJmb3JtYXQgJSBuZXh0X3N0YXRl
ICsgIiB9LCIKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZmLmFwcGVuZChsaW5lKQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZmLmFwcGVuZCgnJy5qb2lu
KCgiXHRcdFx0IiwgbmV4dF9zdGF0ZSwKPiAiXG5cdFx0fSwiKSkpCj4gwqAKPiDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiBzZWxmLl9fYnVmZl90b19zdHJpbmcoYnVmZikKPiDCoAoKVGhhbmtzIGZv
ciBicmluZ2luZyB0aGlzIHVwLCBJJ20gYSBiaXQgdW5kZWNpZGVkIG9uIHRoaXMgb25lLi4KClRo
ZSBuaWNlIHRoaW5nIG9mIHRoZSBjdXJyZW50IHJlcHJlc2VudGF0aW9uIGlzIHRoYXQgaXQgc2hv
d3MgYSBtYXRyaXgKYW5kIGl0J3MgcmVsYXRpdmVseSBlYXN5IHRvIHNlZSB3aGF0IGVhY2ggZXZl
bnQgZG9lcy4KT24gdGhlIG90aGVyIGhhbmQgaXQncyB0cnVlIGxhcmdlciBtb2RlbHMgZG8gZXhj
ZWVkIHF1aXRlIGEgYml0IHRoZQpzaXplIGxpbWl0cyBhbmQgY29uc2lkZXJpbmcgeW91IGFyZW4n
dCByZWFsbHkgc3VwcG9zZWQgdG8gdG91Y2ggdGhpcwpmaWxlIGRpcmVjdGx5IChhcyB0aGUgc2Ny
aXB0IGRvZXMgaXQgZm9yIHlvdSksIHBlcmhhcHMgY2xlYW5lciBDIGNvZGUKc2hvdWxkIGJlIHRo
ZSBwcmlvcml0eS4KCkknbGwgcGxheSB3aXRoIHlvdXIgcGF0Y2ggYW5kIHNlZSBpZiBpdCBuZWdh
dGl2ZWx5IGFmZmVjdHMgdGhlIHdvcmtmbG93CmluIGFueSB3YXkuIElmIG5vdCwgSSdkIGluY2x1
ZGUgaXQgYW5kIGFkYXB0IHRoZSBtb25pdG9ycyAocGVyaGFwcyBvbmx5CnRob3NlIHdpdGggbG9u
ZyBsaW5lcywgbm90IHJlYWxseSBuZWVkIHRvIGNoYW5nZSBhbGwpLgoKVGhhbmtzLApHYWJyaWVs
ZQo=


