Return-Path: <linux-kernel+bounces-824597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC2B89A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9CD7B01E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6A242D90;
	Fri, 19 Sep 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gMW1G2+T"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77CF1DF725
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288235; cv=none; b=n0wN5OPR8GgfLCWmHGzSN3jKSGSol0UNLmo49QabYS75hREjCVJ0xa1c+RvXNGHxO8Z5lslYPoKPEpiaHfO7M2g12w44eD55GNoY13b+UNu08u5xnjBWVhMnzub2KmF0fHXY5IzW4+e10A8kZ7A+o7sm74GDF3T8VqQuqYVjPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288235; c=relaxed/simple;
	bh=T70MbS0K8WkSnx8CHqdI37DUguC+d4jdsViVEfGIAxs=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=iKNXGBsH7Zmc6lZWvSkDujExPuDZy/E49sKYcjptdB3hJBKLb1qixsuvytrUE8CuXOUg02HtYpFlNb+7MgyPp7UxRAAKK28Xsv+VKj+8MbUv5b1CQm0nYXo3PRli93zJUlz7ggAIafPuvtpzDn5F2yVhC4O31NIo5mCoW5toqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gMW1G2+T; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1758288095;
	bh=T70MbS0K8WkSnx8CHqdI37DUguC+d4jdsViVEfGIAxs=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=gMW1G2+TJKbENPB8SYO1N6tosOE8K5QVPnKgHQ497XqPQ2o6HKuZGOjUG9j8M7pA5
	 jNVDvECymcvC0pN+92McbuZgZRnUQDoRvKo+nAqMzZ4gVX0v5OqxOMpmqnTe1IYBk2
	 7xNcx4oR2Wc/HA8X1c6FjB1uPNaGAvKT5dnr67Z8=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT3izQPfYk+lmlkbENMFn3oJT9AK4gN80M=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 0778vltmOfK63PxtYuK9G+mnXvLYboqmCGFS/29NVIuIugbXSNmgi+5KBpkqoIdWpTfdTUuU3HHj5hjXMxU9Kw==
X-QQ-STYLE: 
X-QQ-mid: lv3sz3a-6t1758288093t0f72603b
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>, "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>, "=?utf-8?B?VGhvbWFzIEh1dGg=?=" <thuth@redhat.com>, "=?utf-8?B?WWFvIFpp?=" <ziyao@disroot.org>, "=?utf-8?B?dGdseA==?=" <tglx@linutronix.de>, "=?utf-8?B?WGkgUnVveWFv?=" <xry111@xry111.site>
Cc: "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re:[PATCH] LoongArch: Fix bitflag conflict for TIF_FIXADE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 19 Sep 2025 21:21:32 +0800
X-Priority: 3
Message-ID: <tencent_65BA2C816FF78FD06FE2FE6B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20250919125829.37951-1-ziyao@disroot.org>
In-Reply-To: <20250919125829.37951-1-ziyao@disroot.org>
X-QQ-ReplyHash: 3796280728
X-BIZMAIL-ID: 3095721564594470550
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 19 Sep 2025 21:21:34 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OLsBWtCIHsg6P/JR5jKZTXK+q2HWbV9YWDM/2FnuJIXrxI07V4Q0zyiG
	kJlEnKfXHE0Lybq/oqbWIaoB6w6yf6KW2y3lNqtzFnxSZ1cfRTaUn2DLUtHOmwH8OD8KKwu
	TdQfDpW9lv9fAaiRQ2nf2G1THitNCWF7HjnfVBZ92zuzfedDhZDVSzFOSY61mr8pruPHC8M
	xo03tYl0u6dUHcgA3vO8gggYP86F/dQh1REXk6cHYHAP4lFUAwJMQwXlHmpLEQb8kSjG+FC
	GMB5dmG4NqPusgxWeZt8KYF1yK81IB2DwcMlOv+cj9229yeeqbjo073ppRb/AtwLSmK68Aq
	YJE/oO7+gLXF+BmgdeADt6nbisBfgOzkLEpBkKbeqGTosA7O9IwI8hc8c7cbKDhixPRLVA/
	kgMV0MJcxuLLnyuFT+qu1hyHRWO+r/dHv0CkBgHK6SfGU4w5enUQIaoBO4jVcauNgcnWpaq
	E93Hcv9L4SGEnM+vmo7RAw0pupiAU2YNp3uxyAQR7hPIWNd2jNqitgEZGn7OJQJudNfZx+3
	1glmCxSintNEVkXsUitGaCJIOan+yQG4cMP3VVT63ks+n/wJYxJL89GeStEt1gw/yMb4bqF
	wf8oZllfrTS4MkKfPbvEO4ZX34rcNIEux+LpoUqIUErqwGtKWVkhbXaQcmfAoay2cECTTV0
	1P0d+Ax5meIzsxQHxmUTPBHfHDtJ1nmG+wrShzlU1ByqegwfEwvuCUBib6tI5g9lqkoeB61
	Ijn9YfPWTX1n3gg0u5403agdLTnt+TRjZbK2GYGHV2hGV6kto23dRHGTA3KQyNlwvSX6XXT
	YGEc3CioiSQO0PbRpjpyhy5uOMpAgGNkZ03lfMfqtDUYWcFhMoAqqroGtB167BhIlNQeJAi
	v9MFkfIHrBgJxr7hgD3lvklEkn8B62l4ouHtuuee3tNaJ6PKdzxIC9knEmn6vbH2oClBJ2K
	jns0RtpUl7LVVAQjs4OAtal9+u/wRfgHIH4OUo5vRo1Z5YFcDIXGyNJOW7PmxxcaIRxbwh8
	yXtrnsR+WY8QDRHVgxowc6oCMDftk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

SGVsbG8sDQoNCm5pY2UgY2F0Y2g6KQ0KDQpSZXZpZXdlZC1ieTogV2VudGFvIEd1YW4gPGd1
YW53ZW50YW9AdW5pb250ZWNoLmNvbT4NCg0KQlJzDQpXZW50YW8gR3Vhbg==


