Return-Path: <linux-kernel+bounces-850188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB903BD230F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC62E4EDBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93682F5304;
	Mon, 13 Oct 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRNChaEk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393902DC774
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346111; cv=none; b=gTNEl3aXF/YOgrEw5uw0h+pfXxdzYEEBgqMqkwkUAOjIz8G1jab2RwG6IEISb/CzhL6M+4w4L6xul9OZV8TRL6non++pn1jEnFejkp/tG9WhwPHjhoJOOofob2t4mbp9DVOpF/Hxq21MTt+VfDK+wBqfnHYuDIfprn6niWCjQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346111; c=relaxed/simple;
	bh=slW9f+6jo83HH3W/IVmtXnLD8fDwrW/rvHO5dpvBduw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W75wq6/nKxKDx6v7A0qdca5/D1AjGHzNXJcj1v9Em/4oGAw8RdkvNLIS4JSy7gs7E7lzUokZqa1Rd7eWVK/2+S72vLbgaS3gnV9P+hqhoEBkGsnMW1Osujh/swvSDcadRlWMShG2e68DmgIFO8USdw//zUn5R8bqr3C0FEtZDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRNChaEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760346108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=slW9f+6jo83HH3W/IVmtXnLD8fDwrW/rvHO5dpvBduw=;
	b=LRNChaEkOH4gO+riHWuBlbfxpmUV4sf86eiUjsOUdbRthxP2wNfvWebKrNykPGytXEOVgk
	2MG+B9CZ2kWaxy8wPs5vGdg6vNiWLkIqsbO+KVZxapAl8arPyYgE3rgL8G09WaOIrqFQN2
	p+GoqjssvTNh5SekV3/VmsL9sIj7ks0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-EUq_SSCzNHGxYoUIwckmuQ-1; Mon, 13 Oct 2025 05:01:45 -0400
X-MC-Unique: EUq_SSCzNHGxYoUIwckmuQ-1
X-Mimecast-MFC-AGG-ID: EUq_SSCzNHGxYoUIwckmuQ_1760346104
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4335fa87so25365835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346104; x=1760950904;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slW9f+6jo83HH3W/IVmtXnLD8fDwrW/rvHO5dpvBduw=;
        b=Jv/scyKTO+j14TgxAK9UvRgcy0Xd/t1QS2+qqYaihLvrQ6iNeMAXhrQ+ahJDxl7miy
         edqBJM1N/G2jbvXzo8IwOTNnc1aN6Ia/lEQ9J0WuKrg+70LXR1kJPfEtSyknFELEUuxC
         yWbaGscNAfAHcF1ytEiOU5Ox31aCVTQNAusutbOmqsEEN2eHpZcrSRuCxKOr5kPYcJro
         zvFkmmD1Ux/dZqc1cqTxK1+T/kq7xFDe6dc9h3xmYqN+r7IBMzBJNmnbFPCP07GSslYy
         a3lGVA++fEuYRZeLECE9gY0KC/wfYPBjWtLqn95tZbIKlaQcqGZRI613QVVZXLgz5hFj
         JGbw==
X-Forwarded-Encrypted: i=1; AJvYcCXGCU1yHF2ciFKEhPcoXhp5UTLdREhqUU944qVCV7+CSbuspM+6yk8g5uNvsaAu3NUbeZK/nkgUay3na5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UboNnwKsl6A1QP8qH8A/bCoNboHFXHtLmNRQQJ8lRH/k+UG9
	L3e2R/aYseXYhe4/MXpoGFNU3MEtB+6BQK4TYYZzVf92+wjMr5BIX6IH9ZEEij6Bv0ROOCUDwIA
	j8fx97IULrbYnwP6y6AMCfDmZOZnY3Stg7/AQrLt3+Cg+RROhkKXwHE5VtEV9hcEpKQ==
X-Gm-Gg: ASbGncsfj28qMBOIW1Fg/fqsp17cBsPnyG1k8R5O9f+FWLyEHzEsOXS0lzkz4vYJctG
	oBCB/kPC9D/HJMrEVoI/M0dK8diuCwGRz/AB+eU2d8GIop5tbP0X3PiRB3yPlHYY/NSsw+lwS/P
	iPCO1ztLnodX39X/WZn/62jSYkft3alYmL/XFi1GU1pC3JCKaNRFocKXP7YxII5OyNd8dTCoZfs
	aX9X4LX9OIgQQkPbokl5zSykelKc/acGRAr7C7ACZBnJuLRlrLiYgiYHcVojY8H/lFpcEyvVjOI
	w+OxPaPLWYdbq623xpqTzE2yl2wtSDV8qSwTyoymCiT1oqsU0mQA7zzvLXOa2Coq9A==
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-46fb42ee464mr79867345e9.40.1760346104341;
        Mon, 13 Oct 2025 02:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFi4TnXgYYdjBVUjq86GGeHwVy5qMp+FkkvqLWd/AS5a6ihemSbK0g4AWx01zsxgSE58WEkw==
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:e38d with SMTP id 5b1f17b1804b1-46fb42ee464mr79867165e9.40.1760346103918;
        Mon, 13 Oct 2025 02:01:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d447sm17679041f8f.9.2025.10.13.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:01:43 -0700 (PDT)
Message-ID: <a7b1527165a6551ceb93282a307ec84f6621d73f.camel@redhat.com>
Subject: Re: [PATCH v2 14/20] rv: Add sample hybrid monitors stall
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, linux-doc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 13 Oct 2025 11:01:41 +0200
In-Reply-To: <87frbqygwh.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-15-gmonaco@redhat.com> <87frbqygwh.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI1LTEwLTEwIGF0IDE2OjIzICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+IEdhYnJp
ZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPiB3cml0ZXM6Cj4gPiArLSBOYW1lOiBzdGFs
bCAtIHdha2V1cCBpbiBwcmVlbXB0aXZlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF5eXl5eXl5eXl5eXl5eXl5eXl5eCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvcHktcGFzdGUgbWlzdGFrZT8KCkRhbW4sIHJpZ2h0Li4KCj4gPiArLSBUeXBl
OiBwZXItdGFzayBoeWJyaWQgYXV0b21hdG9uCj4gPiArLSBBdXRob3I6IEdhYnJpZWxlIE1vbmFj
byA8Z21vbmFjb0ByZWRoYXQuY29tPgo+ID4gKwo+ID4gK0Rlc2NyaXB0aW9uCj4gPiArLS0tLS0t
LS0tLS0KPiA+ICsKPiA+ICtUaGUgc3RhbGxlZCB0YXNrIChzdGFsbCkgbW9uaXRvciBpcyBhIHNh
bXBsZSBwZXItdGFzayB0aW1lZCBtb25pdG9yIHRoYXQKPiA+IGNoZWNrcwo+ID4gK2lmIHRhc2tz
IGFyZSBzY2hlZHVsZWQgd2l0aGluIGEgZGVmaW5lZCB0aHJlc2hvbGQgYWZ0ZXIgdGhleSBhcmUg
cmVhZHk6Ogo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSMKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXF1ZXVl
ZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIIDwrCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICM9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
I8KgIHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IHNjaGVkX3dha2V1cDtyZXNldChjbGspwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rwqAgfAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGVucXVldWVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCB8Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoCBjbGsgPCB0aHJlc2hv
bGRfamlmZmllc8KgwqDCoMKgwqAgfMKgIHwKPiA+IHNjaGVkX3N3aXRjaF93YWl0Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tK8KgIHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IHNjaGVkX3N3aXRjaF9pbsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiArwqDCoMKgIHNjaGVkX3N3aXRjaF9pbsKg
wqDCoMKgIHbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiArwqDCoMKgIHNjaGVkX3dha2V1cMKgwqDCoMKgwqAg
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rwqAgfAo+ID4gK8KgICstLS0tLS0t
LS0tLS0tLS0tLS0gfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgfAo+ID4gK8KgIHzCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydW5uaW5nwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIHwKPiA+ICvCoCArLS0tLS0tLS0tLS0tLS0tLS0+IHzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCAtKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiAKPiBJIHRoaW5rIHRo
aXMgbW9uaXRvciBkb2VzIG5vdCBkZXRlY3QgaWYgYSB0YXNrIGdldCBwcmVlbXB0ZWQsIGJ1dCB0
aGVuCj4gbmV2ZXIgZ2V0IHNjaGVkdWxlZCBhZ2Fpbj8KPiAKPiBUaGlzIHNhbXBsZSBtb25pdG9y
IGRvZXMgbm90IGhhdmUgdG8gY292ZXIgZXZlcnl0aGluZyBvYnZpb3VzbHksIGJ1dCBJJ20KPiBj
dXJpb3VzIGlmIEkgdW5kZXJzdGFuZCBpdCBjb3JyZWN0LgoKWWVzLCB0aGF0J3MgcmlnaHQuIEkg
dGhpbmsgSSBjb3VsZCBjb3ZlciB0aGF0IHNjZW5hcmlvIGJ5IGp1c3QgZ29pbmcgYmFjayB0bwpl
bnF1ZXVlZCBhbmQgcmVzZXR0aW5nIHdoZW4gcHJlZW1wdGVkLiBTaW5jZSBpdCdzIGEgc2ltcGxl
IGNoYW5nZSwgaXQncyBwcm9iYWJseQpzb21ldGhpbmcgbWVhbmluZ2Z1bCB0byBkby4uCgpUaGFu
a3MsCkdhYnJpZWxlCg==


