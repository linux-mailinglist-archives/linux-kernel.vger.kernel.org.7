Return-Path: <linux-kernel+bounces-582894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E27A773A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 06:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2D2166A83
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 04:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E218FDBD;
	Tue,  1 Apr 2025 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R2jKweL6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72970A95C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743482877; cv=none; b=kjGPxAKgM2Yw4A+HqT1G87/FBQwyMToHv2K1AtdtCsQRoREo8bp45nvbgfBAXNTRWhA+dNLD56CmRvIjdBsoBtIG+ln+iq9jBHlIMU8YjWBKpuQ8ijyhdqtJXkZnkSy9mvl/azf+GRuX96+zvR3B9KP+vm8qCXSWr66prDNssNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743482877; c=relaxed/simple;
	bh=pdRlylRtWscqEnVbh/Va6IKnH/B2Bw87mJrwkBXsEno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juGnNScAQJzGlxvQdqT61q82PET/ei8ZGQyHU7zNWOkor3qx0x1UhwdGPdz5WH2DDKgK0UsC1cztp08KF+YdGB6ySNv2HhL/on7GleYQxaiLMCGFYwqSqk7r9XHE4syLkDEleXZUOTd2cMap/aNQMjYlhzgfL0a4eGqE0R1ibik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R2jKweL6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-391295490c8so506230f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743482873; x=1744087673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdRlylRtWscqEnVbh/Va6IKnH/B2Bw87mJrwkBXsEno=;
        b=R2jKweL6Bc6pzvdfssx0bmPfsAEsripY1pI9Ax9SjJQsOH9heu98R6N/zNTSmwNvbq
         ziMSgFacC5Xu7wmrDwtJkVy6hjw6aCIoFsf7u+Tlqy0ZTYfXCbTkOGh1rlMwMPa82DsX
         H/egGpyYIsvwDCF0Gr/aMnRiyiC3aSi2N+t33Pha/RJ1bz6RJWoHE5ss6aAuoQu6oBwz
         LzA8QOWniTtqou7iD1Q4qdb+exd5mbOohL6Wyw2D69tJKjOh76jPDmLRcQqQxmxQrWL9
         eBtgp93A89dfKkvcO2QkjuDtl8Y4LgIFnyf0McZrLuvvb2unTjjuwONv0G2CX8xDuvLz
         w3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743482873; x=1744087673;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdRlylRtWscqEnVbh/Va6IKnH/B2Bw87mJrwkBXsEno=;
        b=O5CSFaf0Buy8stjfKog3DH5GcS9WTjOqoqZYoMZ5km4RySMc7DrXMucZEa1ATb9mh+
         tye5iK9Lmj4SGFOLJhznSDBCqZ61fbvAg9KhXmNXdFbWOMFpWf/BU/T/5Kpc/p4irR9v
         mvTEgd+AjEUwtkJmzVAgrWfB6vJQfacqESey7V6GV70/+2PNRWGLXyRI5Wd8GNRfKrjM
         6jvboBNXyafbNo3/7sKEAEOVMlbCxxv/FevjTjfAkS69neuR7E2prmIDKY7qWWClBkeZ
         kMcDzo2edy877hv6qZ7Jqo90TaLoXmFvrf16PWl0WC7YRwz2iBFrCeZv/1h9SR0QaIps
         VtWA==
X-Gm-Message-State: AOJu0Yz+LSzyMKPQDBzxJyEeZtAkRGavn2p8ivqxQ+Xgk5GiTQi76lf1
	EgKUgByc83iYsttZnGqydfGHA9NXrHYKJ93qWUSWGRashUSL1mfR5b9bi7WIvX0=
X-Gm-Gg: ASbGnctZa4rhgd3Em2lQI2ZhlKBdVwajvVf2tYFkJCoKvww9OvzaJ/PdRgO0InR8vCf
	jbErEbV8hTO6/+ByGsNfgwRYYtOaQU3VQ1IPu96R3CMc3k+4nOhIm/s3MF7XIuEP8YPClZc7z9T
	hUs0TPhquif1/N8Z0eVkSI3ufkpsXefBrjr4kotkbXmuqx/vPwZX9JSZ34rF/VtIDnhURsICzYG
	T2DMniYxlQ6TfpaXvPXYLPdKaO2JKZVJg3AfyGomV1Hb9Ak1H81PbSuNtvw+XlEOZXy5ewjxOXP
	V8gs9/vLMsQI7W0UOdmwBRv3kOTI/OcT8Hjcifj8CpNAIXslHNs=
X-Google-Smtp-Source: AGHT+IEeY2bNytPb3ihsugWoNW8hGrlgWaIes48R1sCfv8Mlmy6uP59V7H9Zdjiarts27iYBmLepKA==
X-Received: by 2002:a05:600c:1f10:b0:439:90f5:3919 with SMTP id 5b1f17b1804b1-43ea93c960dmr2921125e9.4.1743482872710;
        Mon, 31 Mar 2025 21:47:52 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b6a093bsm7074323a12.28.2025.03.31.21.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 21:47:52 -0700 (PDT)
Message-ID: <895c59e3-01ab-46e1-b02b-7e65a8484e1c@suse.com>
Date: Tue, 1 Apr 2025 12:47:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] ocfs2: fix write IO performance improvement for
 high fragmentation
To: "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Junxiao Bi <junxiao.bi@oracle.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20250324054851.2509325-1-gautham.ananthakrishna@oracle.com>
 <199205d8-20fb-463d-9065-8021b3cf7cb8@suse.com>
 <DS7PR10MB48784AA2A065605733B79499F7A12@DS7PR10MB4878.namprd10.prod.outlook.com>
 <bcce4e5c-d739-4b1c-86bd-d165ec0780be@suse.com>
 <DS7PR10MB48780B38CDE017917218F22CF7AC2@DS7PR10MB4878.namprd10.prod.outlook.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <DS7PR10MB48780B38CDE017917218F22CF7AC2@DS7PR10MB4878.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhhbmsgR2F1dGhhbSBmb3IgdGhlIHRlc3Rpbmcgam9iLg0KDQpQaW5nIEpvc2VwaC4uLg0K
TGV0J3MgcXVpY2tseSBmaXggdGhpcyBidWcuDQpUaGVyZSBhcmUgdHdvIHdheXMgdG8gZml4
IHRoZSBpc3N1ZSBpbiBjb21taXQgNGViN2I5M2UwMzEwOg0KLSBBYXV0aGFtOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9vY2ZzMi1kZXZlbC9iY2NlNGU1Yy1kNzM5LTRiMWMtODZiZC1k
MTY1ZWMwNzgwYmVAc3VzZS5jb20vVC8jdA0KLSBIZW1pbmc6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL29jZnMyLWRldmVsL2ZhZWY4MTJmLTBhZGMtNGE0Ni05NTFhLTU0NTM5MjdjMjgx
OUBzdXNlLmNvbS9ULyN0DQoNCkluIG15IHZpZXcsIG15IHBhdGNoIGlzIG1vcmUgYmV0dGVy
Lg0KDQotIEhlbWluZw0KDQpPbiA0LzEvMjUgMTI6MzIsIEdhdXRoYW0gQW5hbnRoYWtyaXNo
bmEgd3JvdGU6DQo+IEhJIEhlbWluZywNCj4gDQo+IEkgcmFuIHRoZSB0ZXN0cyBvbiB5b3Vy
IHBhdGNoLCBhbmQgaXQgaXMgd29ya2luZyBmaW5lLiBUaGUgZGlzY29udGlnX3J1bm5lci5z
aCB3YXMgZmFpbGluZyBlYXJsaWVyIGluICJJbm9kZXMgQmxvY2sgR3JvdXAgVGVzdCIuDQo+
IA0KPiBUaGFua3MsDQo+IEdhdXRoYW0uDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAqRnJv
bToqIEhlbWluZyBaaGFvIDxoZW1pbmcuemhhb0BzdXNlLmNvbT4NCj4gKlNlbnQ6KiBUaHVy
c2RheSwgTWFyY2ggMjcsIDIwMjUgMTI6MjMgUE0NCj4gKlRvOiogR2F1dGhhbSBBbmFudGhh
a3Jpc2huYSA8Z2F1dGhhbS5hbmFudGhha3Jpc2huYUBvcmFjbGUuY29tPjsgam9zZXBoLnFp
QGxpbnV4LmFsaWJhYmEuY29tIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+DQo+ICpD
YzoqIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBvY2ZzMi1kZXZlbEBsaXN0cy5saW51eC5kZXYgPG9jZnMyLWRldmVsQGxp
c3RzLmxpbnV4LmRldj47IFJhamVzaCBTaXZhcmFtYXN1YnJhbWFuaW9tIDxyYWplc2guc2l2
YXJhbWFzdWJyYW1hbmlvbUBvcmFjbGUuY29tPjsgSnVueGlhbyBCaSA8anVueGlhby5iaUBv
cmFjbGUuY29tPjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZyA8YWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4NCj4gKlN1YmplY3Q6KiBSZTogW1BBVENIIFJGQyAxLzFdIG9jZnMyOiBm
aXggd3JpdGUgSU8gcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgZm9yIGhpZ2ggZnJhZ21lbnRh
dGlvbg0KPiBPbiAzLzI3LzI1IDE0OjIxLCBHYXV0aGFtIEFuYW50aGFrcmlzaG5hIHdyb3Rl
Og0KPj4gSEkgSGVtaW5nLA0KPj4gDQo+PiBTaGFyaW5nIHRoZSB0ZXN0IHN1aXRlIG1heSBu
b3QgYmUgcHJhY3RpY2FsIChpdCBoYXMgc2hlbGwgc2NyaXB0cywgcHl0aG9uIGFuZCBDIGJp
bmFyaWVzKS4gSG93ZXZlciwgSSBjYW4gdGFrZSBhIGxvb2sgaW50byB5b3VyIHBhdGNoIGFu
ZCBydW4gYSBxdWljayB0ZXN0Lg0KPj4gDQo+PiBUaGFua3MsDQo+PiBHYXV0aGFtLg0KPj4g
DQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcXVpY2sgcmVwbHkgYW5kIHdpbGxpbmduZXNz
IHRvIGhlbHAuDQo+IA0KPiAtIEhlbWluZw0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICpG
cm9tOiogSGVtaW5nIFpoYW8gPGhlbWluZy56aGFvQHN1c2UuY29tPg0KPj4gKlNlbnQ6KiBU
aHVyc2RheSwgTWFyY2ggMjcsIDIwMjUgMTE6MzkgQU0NCj4+ICpUbzoqIEdhdXRoYW0gQW5h
bnRoYWtyaXNobmEgPGdhdXRoYW0uYW5hbnRoYWtyaXNobmFAb3JhY2xlLmNvbT47IGpvc2Vw
aC5xaUBsaW51eC5hbGliYWJhLmNvbSA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPg0K
Pj4gKkNjOiogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IG9jZnMyLWRldmVsQGxpc3RzLmxpbnV4LmRldiA8b2NmczItZGV2
ZWxAbGlzdHMubGludXguZGV2PjsgUmFqZXNoIFNpdmFyYW1hc3VicmFtYW5pb20gPHJhamVz
aC5zaXZhcmFtYXN1YnJhbWFuaW9tQG9yYWNsZS5jb20+OyBKdW54aWFvIEJpIDxqdW54aWFv
LmJpQG9yYWNsZS5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnIDxha3BtQGxpbnV4
LWZvdW5kYXRpb24ub3JnPg0KPj4gKlN1YmplY3Q6KiBSZTogW1BBVENIIFJGQyAxLzFdIG9j
ZnMyOiBmaXggd3JpdGUgSU8gcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgZm9yIGhpZ2ggZnJh
Z21lbnRhdGlvbg0KPj4gSGVsbG8gR2F1dGhhbSwNCj4+IA0KPj4gVGhhbmtzIGZvciBsb2Nh
dGluZyB0aGUgaXNzdWUgYW5kIHN1Ym1pdHRpbmcgYSBwYXRjaC4NCj4+IElzIGl0IHBvc3Np
YmxlIHRvIHNoYXJlIHlvdXIgdGVzdCBjYXNlIGZvciB0aGlzIGJ1Zz8NCj4+IA0KPj4gVGhl
IGtleSBvZiB0aGlzIGJ1ZyBpcyBvY2ZzMl9jbHVzdGVyX2dyb3VwX3NlYXJjaCgpIGNvbXBh
cmluZyB3aXRoIHdyb25nDQo+PiBiaXRzIHNpemUuIEkgaGF2ZSBhbm90aGVyIGZpeCBmb3Ig
dGhpcyBidWcgYW5kIHdpbGwgc2VuZCBpdCB0byB0aGlzIG1haWxpbmcNCj4+IGxpc3QgbGF0
ZXIuDQo+PiANCj4+IFRoYW5rcywNCj4+IEhlbWluZw0KPj4gDQo+PiBPbiAzLzI0LzI1IDEz
OjQ4LCBHYXV0aGFtIEFuYW50aGFrcmlzaG5hIHdyb3RlOg0KPj4+IFRoZSBjb21taXQgNGVi
N2I5M2UwMzEwMWZkM2YzNWU2OWFmZmU1NjZlNGIxZTNlM2RjYSBjYXVzZWQgYSByZWdyZXNz
aW9uDQo+Pj4gaW4gb3VyIHRlc3Qgc3VpdGUgaW4gZGlzY29udGlnIGV4dGVudCB0ZXN0cy4g
VXBvbiB0cm91Ymxlc2hvb3RpbmcgSSBmb3VuZA0KPj4+IFRoZSBmb2xsb3dpbmcgaXNzdWVz
Lg0KPj4+IA0KPj4+IDEuIFRoZSBmdW5jdGlvbiBvY2ZzMl9jbHVzdGVyX2dyb3VwX3NlYXJj
aCgpIHdhcyBjYWxsZWQgZm9yIGRpc2NvbnRpZyBhbGxvY2F0aW9ucw0KPj4+IGFzIHdlbGwu
IEJ1dCBpdCBjaGVja3Mgb25seSB0aGUgY29udGlndW91cyBiaXRzICdiZ19jb250aWdfZnJl
ZV9iaXRzJy4NCj4+PiBJdCBoaXQgdGhlIEVOT1NQQyBpbiB0aGUgZm9sbG93aW5nIGNhc2Ug
aW4gb25lIG9mIHRoZSB0ZXN0cy4NCj4+PiANCj4+PiBvY2ZzMl9ta2RpcigpDQo+Pj7CoMKg
IG9jZnMyX3Jlc2VydmVfbmV3X2lub2RlKCkNCj4+PsKgwqDCoCBvY2ZzMl9yZXNlcnZlX3N1
YmFsbG9jX2JpdHMoKQ0KPj4+wqDCoMKgwqAgb2NmczJfYmxvY2tfZ3JvdXBfYWxsb2MoKQ0K
Pj4+wqDCoMKgwqDCoCBvY2ZzMl9ibG9ja19ncm91cF9hbGxvY19kaXNjb250aWcoKQ0KPj4+
wqDCoMKgwqDCoMKgIF9fb2NmczJfY2xhaW1fY2x1c3RlcnMoKQ0KPj4+wqDCoMKgwqDCoMKg
wqAgb2NmczJfY2xhaW1fc3ViYWxsb2NfYml0cygpDQo+Pj7CoMKgwqDCoMKgwqDCoMKgIG9j
ZnMyX3NlYXJjaF9jaGFpbigpDQo+Pj7CoMKgwqDCoMKgwqDCoMKgwqAgb2NmczJfY2x1c3Rl
cl9ncm91cF9zZWFyY2goKQ0KPj4+IA0KPj4+IExvb2tlZCBsaWtlIHRoZSBjb21taXQgZGlk
IG5vdCBjb25zaWRlciBkaXNjb250aWcgc2VhcmNoZXMuIFRvIGZpeCB0aGlzLA0KPj4+IEkg
aGF2ZSBzcGxpdCBvY2ZzMl9jbHVzdGVyX2dyb3VwX3NlYXJjaCgpIGludG8gKl9jb21tb24o
KSwgKl9jb250aWcoKSBhbmQNCj4+PiAqX2Rpc2NvbnRpZygpDQo+Pj4gDQo+Pj4gMi4gVGhh
dCBjb21taXQgZW5mb3JjZWQgb2NmczJfY2x1c3Rlcl9ncm91cF9zZWFyY2goKSB0byBzZWFy
Y2ggb25seSB0aGUNCj4+PiAnYml0c193YW50ZWQnIG51bWJlciBvZiBiaXRzIHdoZXJlYXMg
b2NmczJfYmxvY2tfZ3JvdXBfZmluZF9jbGVhcl9iaXRzKCkNCj4+PiBmaWxscyB0aGUgYmVz
dCBhdmFpbGFibGUgc2l6ZSBhbmQgdGhlIGZ1bmN0aW9uIG9jZnMyX2NsdXN0ZXJfZ3JvdXBf
c2VhcmNoKCkNCj4+PiBpdHNlbGYgaXMgc3VwcG9zZWQgdG8gc2VhcmNoICdtaW5fYml0cycg
YXQgdGhlIG1pbmltdW0gYW5kIG5lZWQgbm90IGJlDQo+Pj4gJ2JpdHNfd2FudGVkJyBhbHdh
eXMuDQo+Pj4gDQo+Pj4gRml4ZWQgdGhlIGFib3ZlIGlzc3VlcyBpbiB0aGlzIHBhdGNoLg0K
Pj4+IFRoaXMgcGF0Y2ggZml4ZXMgNGViN2I5M2UwMzEwMWZkM2YzNWU2OWFmZmU1NjZlNGIx
ZTNlM2RjYQ0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEdhdXRoYW0gQW5hbnRoYWtyaXNo
bmEgPGdhdXRoYW0uYW5hbnRoYWtyaXNobmFAb3JhY2xlLmNvbT4NCj4+PiAtLS0NCj4+PsKg
wqAgZnMvb2NmczIvc3ViYWxsb2MuYyB8IDE0NiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQ0KPj4+wqDCoCAxIGZpbGUgY2hhbmdlZCwgOTUgaW5zZXJ0
aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pDQo+Pj4gDQo+IA0KDQo=

