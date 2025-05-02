Return-Path: <linux-kernel+bounces-629221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF330AA694D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 05:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447331B67399
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1AA1A01BF;
	Fri,  2 May 2025 03:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="iW7cFQmH"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E454F18FDBE;
	Fri,  2 May 2025 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746156184; cv=none; b=STNulmw62ug9hkxkZAK+F3fbj4hsccrWqp+NE+0hQLBFLsp5oHxrker3Cm+A8s1Hla537uSm6iEE/pQkvIhapNRo6umiskISasemq4xvp7IFCqms5wZi4C05ReYtQ2NDbjLBtz1X7XdwZHe9uhubzZL9WIzvReTvvYn+uexGMBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746156184; c=relaxed/simple;
	bh=ckYDWQwEPzMY+F4FVGR8/ZX72Uz3k8AqlwHf/u2+w40=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XCc0GSPfnOJeNFTf7QsEhAWgLst0k1Mk5lOxUC6+co+RgOltXGs3VN94HAi9PEZrvElPStzfphi6LAT0jqnqDfw4eujxGIC3iDI002+85lCZkvn3MpRzOBelQUZmASlQCOE4PgLuBNSRxJ82bbVHSs2wv+2LY8tCN+01lxvQaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=iW7cFQmH; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1746156140;
	bh=ckYDWQwEPzMY+F4FVGR8/ZX72Uz3k8AqlwHf/u2+w40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iW7cFQmHsVFFQ/2ZiTPdlqWAp1b0lErWdFppEGRddczGcVCaUMfK4x4eor6d4VkHJ
	 TlUuoptapO0cwpS8DKeMgOYzYEf3drHbGH05ghFUtvw1Ex3pzPSClkCPNDfGWuYKb9
	 A7tBM7oh+PJQCnbPOODkKeqSDmq+NFoNxzH3Wx+0=
X-QQ-mid: zesmtpip4t1746156135t5c301e7a
X-QQ-Originating-IP: zKhRLbclV4BV+CKjip09tor4cB/qKGuZedKdI9w6FN0=
Received: from TYSPR06MB7158.apcprd06.prod.out ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 02 May 2025 11:22:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15003951076817169931
EX-QQ-RecipientCnt: 6
From: "huk23@m.fudan.edu.cn" <huk23@m.fudan.edu.cn>
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
	=?utf-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>, linux-bcachefs
	<linux-bcachefs@vger.kernel.org>, "syzkaller@googlegroups.com"
	<syzkaller@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: WARNING in bch2_fs_release
Thread-Topic: WARNING in bch2_fs_release
Thread-Index: AQHbuxC8lMGcXxXIU0uK+izgNGf1ng==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 2 May 2025 03:22:13 +0000
Message-ID:
	<TYSPR06MB715874368EFB5D2A09C527B1F68D2@TYSPR06MB7158.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OZsapEVPoiO6rTDBM1jxg1PPAgKRd7XMi5vNPZROXionvXlGTg3UkS+y
	7/Zi8Fb/3D/fMLNle7OBrO/9S4Y/8nKQSqzVoLRGaUJ84G19FGLIQeLYU4zRUln6QLIDju7
	HADBuqUz8G3ACZiTH+JL36rDO684I7bz81QSvh5k2w+UCE5ijlYpo7zH9Ftwf4e9tm59xoJ
	8XJoe2uRoOaqGpSl/HQ7NnjQScns/+JzRJUVqnXLKfXQjNnaXDNODnARANsWTaKYr0usK4o
	avrN/mI/Em0fMGfQP+J7r5W0LEXVCaRmsP1w3Mzj2KoBaCmvneVccJ14g6SIZmdxVwl3imS
	lkQYtun3BBb1LQT7R3kjopxee1Al77nlyX1XBVdqrSEs7VeczSwpQMcfNe8VgYVp97P8FB8
	94Nr9mVwNwLV43hxuXZE6e92ovcnaJQlvKn72V8rA+fpUUU2KHBMEo3gIKCbIp8eBqtK4yK
	8AoWqOro5KpEM9+lj1WKpPxv4qqnm+/PnaseVKV/c4Z/KNB7i8oyFpuyuOBmgQxG/AjNNVL
	qEl/aHkbIbyCicJ+9VhRZvm2VF8fywIpcUWbsi8lteITw793vWl+f6tquxF/0GpyAb0HPnD
	G9Z3xq5eLq2uwB78mVzkX8+Aw27d9/+DX/KTG7Z0gUBgQF9nZVuouihz3x3Y88IDatjysPy
	EJddvjUL73w//ue1aoAF9dMwkn0zrS+jf8zKqG7pVbMlFvK+Tj6yVt+DAv35lw1v0pc6kSi
	SHBIJgEO+DEokiuUc4TNq8ZhCfWrxQ77C6sY9v8IlSO7LRWi4j4iS0Fpj5bEAdlxKZNJP6N
	Stw8/4OSQbEZSQuFHF5wlou8uSEbp0bEX4EJCNMvar5h6lbrh9CCe2bw4U/NQWhRtPscqKY
	MrnBAyYQ4OVOzF5oK5TpxyUHpOAJ8LNGW9CgwWwpTHRy8uQhodroibmCsfkin0KuSMhG4Dy
	93GL48px7+Sf3SQt91eDluQEn9dYMV4b34HNwHinQEj5RaUtazq24I+rbROJhBywhcblGmj
	XC5BcQJ+YAVV1ygJoNyCEi7+Sz+qxtiB9yEmqqvWTPr0O9C+JFcrlAPqVBEz0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

RGVhciBNYWludGFpbmVycywKCgoKCldoZW4gdXNpbmcgb3VyIGN1c3RvbWl6ZWQgU3l6a2FsbGVy
IHRvIGZ1enogdGhlIGxhdGVzdCBMaW51eCBrZXJuZWwsIHRoZSBmb2xsb3dpbmcgY3Jhc2ggKDEx
dGgpd2FzIHRyaWdnZXJlZC4KCgoKCgpIRUFEIGNvbW1pdDogNjUzN2NmYjM5NWYzNTI3ODI5MThk
OGVlN2I3ZjEwYmEyY2MzY2JmMgpnaXQgdHJlZTogdXBzdHJlYW0KT3V0cHV0Omh0dHBzOmh0dHBz
Oi8vZ2l0aHViLmNvbS9wZ2hrMTMvS2VybmVsLUJ1Zy9ibG9iL21haW4vMTIyMF82LjEzcmNfS0FT
QU4vMi4lRTUlOUIlOUUlRTUlQkQlOTItMTEvMTEtS0FTQU5fJTIwc2xhYi11c2UtYWZ0ZXItZnJl
ZSUyMFJlYWQlMjBpbiUyMG1vdmVfdG9fbmV3X2ZvbGlvLzExY2FsbF90cmFjZS50eHQKS2VybmVs
IGNvbmZpZzpodHRwczovL2dpdGh1Yi5jb20vcGdoazEzL0tlcm5lbC1CdWcvYmxvYi9tYWluL2Nv
bmZpZy50eHQKQyByZXByb2R1Y2VyOmh0dHBzOmh0dHBzOi8vZ2l0aHViLmNvbS9wZ2hrMTMvS2Vy
bmVsLUJ1Zy9ibG9iL21haW4vMTIyMF82LjEzcmNfS0FTQU4vMi4lRTUlOUIlOUUlRTUlQkQlOTIt
MTEvMTEtS0FTQU5fJTIwc2xhYi11c2UtYWZ0ZXItZnJlZSUyMFJlYWQlMjBpbiUyMG1vdmVfdG9f
bmV3X2ZvbGlvLzExcmVwcm8uYwpTeXpsYW5nIHJlcHJvZHVjZXI6IGh0dHBzOi8vZ2l0aHViLmNv
bS9wZ2hrMTMvS2VybmVsLUJ1Zy9ibG9iL21haW4vMTIyMF82LjEzcmNfS0FTQU4vMi4lRTUlOUIl
OUUlRTUlQkQlOTItMTEvMTEtS0FTQU5fJTIwc2xhYi11c2UtYWZ0ZXItZnJlZSUyMFJlYWQlMjBp
biUyMG1vdmVfdG9fbmV3X2ZvbGlvLzExcmVwcm8udHh0CgoKVGhlIGVycm9yIGlzIGxvY2F0ZWQg
b24gbGluZSA1OTIgb2YgdGhlIGZzL2JjYWNoZWZzL3N1cGVyLmMgZmlsZSwgaW4gdGhlIGJjaDJf
ZnNfcmVsZWFzZSBmdW5jdGlvbi4gQmFzZWQgb24gdGhlIGVycm9yIG1lc3NhZ2UgYW5kIHRoZSBj
YWxsIHN0YWNrLCB0aGUgcHJvYmxlbSBpcyB0aGF0IGFsbCByZXNlcnZlZCByZXNvdXJjZXMgYXJl
IG5vdCBwcm9wZXJseSByZWxlYXNlZCB3aGVuIHRoZSBiY2FjaGVmcyBmaWxlIHN5c3RlbSBpcyBk
b3duLgpXZSBoYXZlIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZSBzZXZlcmFsIHRpbWVzIG9uIDYuMTUt
cmMxIGFnYWluLgoKCgoKCgpJZiB5b3UgZml4IHRoaXMgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZv
bGxvd2luZyB0YWcgdG8gdGhlIGNvbW1pdDoKUmVwb3J0ZWQtYnk6IEt1biBIdSA8aHVrMjNAbS5m
dWRhbi5lZHUuY24+LCBKaWFqaSBRaW4gPGpqdGFuMjRAbS5mdWRhbi5lZHUuY24+LCBTaHVvcmFu
IEJhaSA8YmFpc2h1b3JhbkBocmJldS5lZHUuY24+Cgo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCm9ubGluZV9yZXNlcnZl
ZCBub3QgMCBhdCBzaHV0ZG93bjogMQpXQVJOSU5HOiBDUFU6IDEgUElEOiAxMzM2NiBhdCBmcy9i
Y2FjaGVmcy9zdXBlci5jOjU5MiBiY2gyX2ZzX3JlbGVhc2UrMHg3MzUvMHg4YjAKTW9kdWxlcyBs
aW5rZWQgaW46CkNQVTogMSBVSUQ6IDAgUElEOiAxMzM2NiBDb21tOiBzeXouMS40NSBOb3QgdGFp
bnRlZCA2LjE1LjAtcmMxICMxIFBSRUVNUFQoZnVsbCkKSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFu
ZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xMy4wLTF1YnVudHUxLjEgMDQv
MDEvMjAxNApSSVA6IDAwMTA6YmNoMl9mc19yZWxlYXNlKzB4NzM1LzB4OGIwCkNvZGU6IDg5IGVm
IGU4IGJlIDRmIGQxIGZmIGU5IDg2IGZhIGZmIGZmIGU4IGU0IGFlIDU0IGZkIDkwIDBmIDBiIGU4
IGRjIGFlIDU0IGZkIDkwIDQ4IGM3IGM3IGEwIDg3IGU2IDhiIDRjIDg5IGU2IGU4IGNjIDMxIDE0
IGZkIDkwIDwwZj4gMGIgOTAgOTAgNDggYjggMDAgMDAgMDAgMDAgMDAgZmMgZmYgZGYgNDggOGIg
NTQgMjQgMTAgNDggYzEgZWEKUlNQOiAwMDE4OmZmZmZjOTAwMDI2YzczNTggRUZMQUdTOiAwMDAx
MDI4MgpSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmODg4MDc1ZTAwMDY4IFJDWDogZmZm
ZmZmZmY4MTdhOTY2OQpSRFg6IDAwMDAwMDAwMDAwMDAwMDEgUlNJOiBmZmZmODg4MDFmYmE0OTAw
IFJESTogMDAwMDAwMDAwMDAwMDAwMgpSQlA6IGZmZmY4ODgwNzVlMDAwMDAgUjA4OiBmZmZmZmJm
ZmYxYzRiYjAwIFIwOTogZmZmZmVkMTAwZmRjNDdiYQpSMTA6IGZmZmZlZDEwMGZkYzQ3YjkgUjEx
OiBmZmZmODg4MDdlZTIzZGNiIFIxMjogMDAwMDAwMDAwMDAwMDAwMQpSMTM6IDAwMDA2MDdmMTQ5
MWUxNDggUjE0OiBkZmZmZmMwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApGUzogwqAw
MDAwN2ZjYjEwZWJmNzAwKDAwMDApIEdTOmZmZmY4ODgwZWIzNmIwMDAoMDAwMCkga25sR1M6MDAw
MDAwMDAwMDAwMDAwMApDUzogwqAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4
MDA1MDAzMwpDUjI6IDAwMDA3ZjkzYzVkNGMwMDAgQ1IzOiAwMDAwMDAwMDZjMmU2MDAwIENSNDog
MDAwMDAwMDAwMDc1MGVmMApQS1JVOiAwMDAwMDAwMApDYWxsIFRyYWNlOgrCoDxUQVNLPgrCoGtv
YmplY3RfcHV0KzB4MWIyLzB4NGMwCsKgYmNoMl9mc19hbGxvYysweGNmZS8weDI5YjAKwqBiY2gy
X2ZzX29wZW4rMHg5NDUvMHgxMTYwCsKgYmNoMl9mc19nZXRfdHJlZSsweDNjOS8weDIwYzAKwqB2
ZnNfZ2V0X3RyZWUrMHg5My8weDM0MArCoHBhdGhfbW91bnQrMHgxMjcwLzB4MWI5MArCoGRvX21v
dW50KzB4YjMvMHgxMTAKwqBfX3g2NF9zeXNfbW91bnQrMHgxOTMvMHgyMzAKwqBkb19zeXNjYWxs
XzY0KzB4Y2YvMHgyNjAKwqBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdm
ClJJUDogMDAzMzoweDdmY2IwZmZhZjUxZQpDb2RlOiBmZiBmZiBmZiA2NCBjNyAwMCAxNiAwMCAw
MCAwMCBiOCBmZiBmZiBmZiBmZiBjMyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCA2NiA5
MCBmMyAwZiAxZSBmYSA0OSA4OSBjYSBiOCBhNSAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAxIGYw
IGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGIwIGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAxIDQ4ClJT
UDogMDAyYjowMDAwN2ZjYjEwZWJlOWI4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAw
MDAwMDAwMDAwYTUKUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwNTkwNSBS
Q1g6IDAwMDA3ZmNiMGZmYWY1MWUKUkRYOiAwMDAwMDAwMDIwMDA1OGMwIFJTSTogMDAwMDAwMDAy
MDAwNTkwMCBSREk6IDAwMDA3ZmNiMTBlYmVhMTAKUkJQOiAwMDAwN2ZjYjEwZWJlYTUwIFIwODog
MDAwMDdmY2IxMGViZWE1MCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKUjEwOiAwMDAwMDAwMDAwMDAw
MDAwIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMjAwMDU4YzAKUjEzOiAwMDAw
MDAwMDIwMDA1OTAwIFIxNDogMDAwMDdmY2IxMGViZWExMCBSMTU6IDAwMDAwMDAwMjAwMDAxYzAK
CgoKdGhhbmtzLApLdW4gSHU=

