Return-Path: <linux-kernel+bounces-739244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E439EB0C3D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EE41AA2FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD22C3247;
	Mon, 21 Jul 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMOLLRJe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065162BDC27
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099644; cv=none; b=KCKh7/qZ7lSQnpI/Kl3VgVDUvRxiO8XkeEVhcou8J2bRM9wmf7uYrMsyytByKVYddIDOrNZsC7s90HM++lu5HcP6rgWFKqM1K+KppCukilccwxDVUxcfIh7vRg1zkWdFrznF/1V4QfbxcJgDRFyxtYDwuJfYas34pXpZdjZRJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099644; c=relaxed/simple;
	bh=W6w+Cmad4MsKz5ziTLisxvKwhPm1UV5prs181NSsSpY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bbw1r4J72Ad5Scw3XiAMgZx04mJlar3MSZH1dOZ26fdX5caZ9jhNSwz+8uL5BrdC/p+veOYMdY56QNi4Sjq2qvnj2wgJZ5nJzIylMYbeUfYcSfeObJ8klRYgeHKJGm8U6vFU33vU2XItua+b7Kt2aSvhx0wS+gkNRoyldGt5eAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMOLLRJe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753099641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W6w+Cmad4MsKz5ziTLisxvKwhPm1UV5prs181NSsSpY=;
	b=NMOLLRJeu4Kj5yZcKWmElm8+0G5h1ScgWFnaWvQfS/15b2PD8DpPa9z/YNWY1qZKCA9uqq
	tM74L50vosZ1Snwk+CqwTEqL7qEEPeXXFpjuWCvjPu0sN6WWhVfR8EX+uIv0ZxJTO91e2g
	2L2FpiMflwQU6Py+xezyrOXiu+jscOo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-_tgIBuaJOZOVUtqCANnDPw-1; Mon, 21 Jul 2025 08:07:20 -0400
X-MC-Unique: _tgIBuaJOZOVUtqCANnDPw-1
X-Mimecast-MFC-AGG-ID: _tgIBuaJOZOVUtqCANnDPw_1753099639
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-456175dba68so34207025e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753099639; x=1753704439;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6w+Cmad4MsKz5ziTLisxvKwhPm1UV5prs181NSsSpY=;
        b=eg8fO2dews8okFN/LsRN06MbV8EbYehdwxxsz4xwKsv54KHEA3BFUHe8MhnqswvYQF
         nqFePdB2MNhzFEbc9d2ufNVaQ1sTsR3EY5ktaysh555vdhor6hWpcE+IQOY0VcTiZL7N
         WQVQ5/HBB+ApBS8cZLaEmlSJc94VxSsSXQDoROSu3HCiquhOZlcBeFV/kkPWBXl8RWam
         acwe0Z5tfbp0qkuFh0OnFbqeAzVKIY/hzdg5nz4OVuuDz3HqK+DBF9aEPHtK9phITxVj
         MCNfH6wjJWwhH9K/3AQbWcz7JJ4oNTKEEDV1K+CiYGAsC09KOegis/MFExUiY1PRmatw
         Vr5w==
X-Forwarded-Encrypted: i=1; AJvYcCWTKriL5mrTgeMxqLoHVE0of/S6WP/AXapCsbYCfCl9wVsCpJadB8FEuhW7xOxBIDtQIhTJoSGhYF/gkuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPokjuIrrgLU6z4kG7KuxSOE+yHxDCwhI72RKoNqmmzOt893SP
	U31NZo2u6ihPOqw5Helult90Ql7rBwuEDqmnnMYnYMlzZbFQYDhrwQDW4mhjlmsnmzrCmy3GSBn
	LRTETc6kFhKsCpXh+PpJZ1V1qvaIIjYS5bgNYWxady0duJSiwghlFZj765wfb8wMXNg==
X-Gm-Gg: ASbGncs7cuj9+DHpW0R+eLtZbNfERDQqBv57gkBv6lOAQ2dHAlx/2CH0etEWmxkXAEP
	OWF/reAFbYlQaeHmonXjph5D61LABu4Yj3XOu+orpXJRVcNJ/xZCBLL8R+esh6EIVgd1IhZ4PU7
	7cgWEJJIpYjVP7a72NkTdVWAtinq32wvySSNoETNoQT+jW67gHtfJrM1bcRxqjSe76Yt6fzsUD/
	g9N8dXPKwvXJk6lbxjkY6gLvo1yKb4ViFP+zPIVYK6BqryIE1kLdGHXjO3uygvPHbztE2FHRCeG
	dzd1V9KWY8oFbzcO8jyGBemoypiJtTvBOu1OhOpfflSnQbeyQUojBUwtC6VGA7MpYw==
X-Received: by 2002:a05:6000:1a8b:b0:3b3:c4b1:a212 with SMTP id ffacd0b85a97d-3b60e4b8576mr15495232f8f.7.1753099639233;
        Mon, 21 Jul 2025 05:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUvbI/CfwwnEkTK8hKXubcNeMcY56S29TCgkmo+UmRsG0JqHV1Q/+3pToH1ysboduZm01Fxw==
X-Received: by 2002:a05:6000:1a8b:b0:3b3:c4b1:a212 with SMTP id ffacd0b85a97d-3b60e4b8576mr15495191f8f.7.1753099638732;
        Mon, 21 Jul 2025 05:07:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm10279837f8f.36.2025.07.21.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:07:18 -0700 (PDT)
Message-ID: <87c5e103780e8d8d0cef27cb3cba69ab0bcb9b1f.camel@redhat.com>
Subject: Re: [PATCH 2/2] verification/rvgen: Do not generate unused variables
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 14:07:15 +0200
In-Reply-To: <636b2b2d99a9bd46a9f77a078d44ebd7ffc7508c.1752850449.git.namcao@linutronix.de>
References: <cover.1752850449.git.namcao@linutronix.de>
	 <636b2b2d99a9bd46a9f77a078d44ebd7ffc7508c.1752850449.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTA3LTE4IGF0IDE2OjU4ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IGx0bDJr
IGdlbmVyYXRlcyBhbGwgdmFyaWFibGUgZGVmaW5pdGlvbiBpbiBib3RoIGx0bF9zdGFydCgpIGFu
ZAo+IGx0bF9wb3NzaWJsZV9uZXh0X3N0YXRlcygpLiBIb3dldmVyLCB0aGVzZSB0d28gZnVuY3Rp
b25zIG1heSBub3QgdXNlCj4gYWxsCj4gdGhlIHZhcmlhYmxlcywgY2F1c2luZyAidW51c2VkIHZh
cmlhYmxlIiBjb21waWxlciB3YXJuaW5nLgo+IAo+IENoYW5nZSB0aGUgc2NyaXB0IHRvIG9ubHkg
Z2VuZXJhdGUgdXNlZCB2YXJpYWJsZXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmFtIENhbyA8bmFt
Y2FvQGxpbnV0cm9uaXguZGU+CgpUcmllZCBib3RoIHBhdGNoZXMgYW5kIHRoZXkgc2VlbSB0byB3
b3JrIGFzIGludGVuZGVkLgoKUmV2aWV3ZWQtYnk6IEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0By
ZWRoYXQuY29tPgoKVGhhbmtzLApHYWJyaWVsZQoKPiAtLS0KPiDCoHRvb2xzL3ZlcmlmaWNhdGlv
bi9ydmdlbi9ydmdlbi9sdGwyay5weSB8IDI1ICsrKysrKysrKysrKysrKysrKysrKy0tCj4gLS0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+
IGRpZmYgLS1naXQgYS90b29scy92ZXJpZmljYXRpb24vcnZnZW4vcnZnZW4vbHRsMmsucHkKPiBi
L3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9sdGwyay5weQo+IGluZGV4IDU5ZGEzNTE3
OTJlYy4uYjA3NWY5OGQ1MGM0IDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdl
bi9ydmdlbi9sdGwyay5weQo+ICsrKyBiL3Rvb2xzL3ZlcmlmaWNhdGlvbi9ydmdlbi9ydmdlbi9s
dGwyay5weQo+IEBAIC0xMDYsMjAgKzEwNiwyNSBAQCBjbGFzcyBsdGwyayhnZW5lcmF0b3IuTW9u
aXRvcik6Cj4gwqDCoMKgwqDCoMKgwqDCoCBdKQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGJ1
Zgo+IMKgCj4gLcKgwqDCoCBkZWYgX2ZpbGxfYXRvbV92YWx1ZXMoc2VsZik6Cj4gK8KgwqDCoCBk
ZWYgX2ZpbGxfYXRvbV92YWx1ZXMoc2VsZiwgcmVxdWlyZWRfdmFsdWVzKToKPiDCoMKgwqDCoMKg
wqDCoMKgIGJ1ZiA9IFtdCj4gwqDCoMKgwqDCoMKgwqDCoCBmb3Igbm9kZSBpbiBzZWxmLmx0bDoK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBub2RlLm9wLmlzX3RlbXBvcmFsKCk6Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgc3RyKG5vZGUpIG5vdCBpbiByZXF1aXJlZF92YWx1ZXM6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWUKPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiBpc2luc3RhbmNlKG5vZGUub3AsIGx0bDJiYS5BbmRPcCk6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmLmFwcGVuZCgiXHRib29sICVz
ID0gJXMgJiYgJXM7IiAlIChub2RlLAo+IG5vZGUub3AubGVmdCwgbm9kZS5vcC5yaWdodCkpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXF1aXJlZF92YWx1ZXMgfD0ge3N0cihu
b2RlLm9wLmxlZnQpLAo+IHN0cihub2RlLm9wLnJpZ2h0KX0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZWxpZiBpc2luc3RhbmNlKG5vZGUub3AsIGx0bDJiYS5Pck9wKToKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWYuYXBwZW5kKCJcdGJvb2wgJXMgPSAlcyB8fCAlczsi
ICUgKG5vZGUsCj4gbm9kZS5vcC5sZWZ0LCBub2RlLm9wLnJpZ2h0KSkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJlcXVpcmVkX3ZhbHVlcyB8PSB7c3RyKG5vZGUub3AubGVmdCks
Cj4gc3RyKG5vZGUub3AucmlnaHQpfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbGlmIGlz
aW5zdGFuY2Uobm9kZS5vcCwgbHRsMmJhLk5vdE9wKToKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBidWYuYXBwZW5kKCJcdGJvb2wgJXMgPSAhJXM7IiAlIChub2RlLAo+IG5vZGUu
b3AuY2hpbGQpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxdWlyZWRfdmFs
dWVzLmFkZChzdHIobm9kZS5vcC5jaGlsZCkpCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgIGZvciBh
dG9tIGluIHNlbGYuYXRvbXM6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgYXRvbS5sb3dl
cigpIG5vdCBpbiByZXF1aXJlZF92YWx1ZXM6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb250aW51ZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWYuYXBwZW5kKCJcdGJv
b2wgJXMgPSB0ZXN0X2JpdChMVExfJXMsIG1vbi0+YXRvbXMpOyIgJQo+IChhdG9tLmxvd2VyKCks
IGF0b20pKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBidWYucmV2ZXJzZSgpCj4gQEAgLTEzNSw3
ICsxNDAsMTMgQEAgY2xhc3MgbHRsMmsoZ2VuZXJhdG9yLk1vbml0b3IpOgo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAibHRsX3Bvc3NpYmxlX25leHRfc3RhdGVzKHN0cnVjdCBsdGxfbW9uaXRv
ciAqbW9uLAo+IHVuc2lnbmVkIGludCBzdGF0ZSwgdW5zaWduZWQgbG9uZyAqbmV4dCkiLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAieyIKPiDCoMKgwqDCoMKgwqDCoMKgIF0KPiAtwqDCoMKg
wqDCoMKgwqAgYnVmLmV4dGVuZChzZWxmLl9maWxsX2F0b21fdmFsdWVzKCkpCj4gKwo+ICvCoMKg
wqDCoMKgwqDCoCByZXF1aXJlZF92YWx1ZXMgPSBzZXQoKQo+ICvCoMKgwqDCoMKgwqDCoCBmb3Ig
bm9kZSBpbiBzZWxmLmJhOgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciBvIGluIHNvcnRl
ZChub2RlLm91dGdvaW5nKToKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcXVp
cmVkX3ZhbHVlcyB8PSBvLmxhYmVscwo+ICsKPiArwqDCoMKgwqDCoMKgwqAgYnVmLmV4dGVuZChz
ZWxmLl9maWxsX2F0b21fdmFsdWVzKHJlcXVpcmVkX3ZhbHVlcykpCj4gwqDCoMKgwqDCoMKgwqDC
oCBidWYuZXh0ZW5kKFsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiIsCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJcdHN3aXRjaCAoc3RhdGUpIHsiCj4gQEAgLTE2Niw3ICsxNzcsMTMg
QEAgY2xhc3MgbHRsMmsoZ2VuZXJhdG9yLk1vbml0b3IpOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAic3RhdGljIHZvaWQgbHRsX3N0YXJ0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgc3Ry
dWN0Cj4gbHRsX21vbml0b3IgKm1vbikiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAieyIK
PiDCoMKgwqDCoMKgwqDCoMKgIF0KPiAtwqDCoMKgwqDCoMKgwqAgYnVmLmV4dGVuZChzZWxmLl9m
aWxsX2F0b21fdmFsdWVzKCkpCj4gKwo+ICvCoMKgwqDCoMKgwqDCoCByZXF1aXJlZF92YWx1ZXMg
PSBzZXQoKQo+ICvCoMKgwqDCoMKgwqDCoCBmb3Igbm9kZSBpbiBzZWxmLmJhOgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIG5vZGUuaW5pdDoKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJlcXVpcmVkX3ZhbHVlcyB8PSBub2RlLmxhYmVscwo+ICsKPiArwqDCoMKgwqDCoMKg
wqAgYnVmLmV4dGVuZChzZWxmLl9maWxsX2F0b21fdmFsdWVzKHJlcXVpcmVkX3ZhbHVlcykpCj4g
wqDCoMKgwqDCoMKgwqDCoCBidWYuYXBwZW5kKCIiKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoCBm
b3Igbm9kZSBpbiBzZWxmLmJhOgo=


