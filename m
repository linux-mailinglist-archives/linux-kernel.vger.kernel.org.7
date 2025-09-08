Return-Path: <linux-kernel+bounces-806492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01910B497BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1CB7AFF8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC7314B69;
	Mon,  8 Sep 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNsYZtrc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4E31327F;
	Mon,  8 Sep 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354316; cv=none; b=I2Kh9zHiKqQZTFpxO3LEzsg5du71BbIoysfOkqaBvHccw2ipZYrNxZM06JEu9WFuTu9IW6rgjZK09gJ/1iWbqyHgsL3Ot2kEDGaG23ltNFi8xplt0wcFR8IDzUc3A0ycjwoFBwRuO18rdVumksX/PmRtKkIidvEkUeem0hiRnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354316; c=relaxed/simple;
	bh=gt0EpPEAyoApJr09LrsCXlMB+0xjP2bmwcOFF+Pv5Sw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=YgSZ4Idh1k4NWZcGdw/kUvk0t28yOT+buKHc2U8AryU/iycfRDPKMX4Ou+d4k8ItRdXtJJsXLrJ9rUPe8y+UPNq/8kC/p4YrGy500zjQzxSxX4iucxESMyVCwgqTHS4aMQyDO7VFEebYXRsJetEyF+8NlqdgFFBEMCPQXYy6lSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNsYZtrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC3EC4CEF5;
	Mon,  8 Sep 2025 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757354315;
	bh=gt0EpPEAyoApJr09LrsCXlMB+0xjP2bmwcOFF+Pv5Sw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MNsYZtrcdT+iWGtZ2zWmzMIStr5RyYgtdbBlMm7gPfJqXZ40FhR1kOjXOowgn5uMq
	 Umikt3vwRgYlwXbbjvagqhwS6Kh+kfY/vp3Wj4tdYWkMUjB10vu7eWbLwOvI1ES25g
	 GSIfuu/mkmE0tam8dphlXs8bEqxTis+zBUayiuJ62V0Eepu9DG2KLKllYbxHZkIEu8
	 Cbkw/Kx7rKdc0bKJJ10fMi2J1b6in/SkNs9Dk1442fZO0n7fDL7YVLrVffWTGVI7gt
	 /A5W7mt7madDGHoI3k79o5gdKDAloAze1KbxdcBF07o+c4J9UJDmDM7UhO+oh863gJ
	 gQy0NQSWmyjLw==
Content-Type: multipart/mixed; boundary="------------eNldNmG8FKXO6slpRWvrzn9e"
Message-ID: <197e6b98-e390-4080-a3e8-a42e0b2cd674@kernel.org>
Date: Mon, 8 Sep 2025 19:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Dirk Beheme <dirk.behme@de.bosch.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
 <2025090817-attendant-ungodly-78f6@gregkh>
 <DCNGJMN80Z34.1O45B1LM9PB2S@kernel.org> <2025090850-canon-banish-baf6@gregkh>
 <DCNIASL0KG57.3LC7NU7COE5KU@kernel.org>
 <2025090808-slicer-consent-6db0@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025090808-slicer-consent-6db0@gregkh>

This is a multi-part message in MIME format.
--------------eNldNmG8FKXO6slpRWvrzn9e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/25 6:19 PM, Greg Kroah-Hartman wrote:
> Working code for the simple "foo" example will be good.  Here's my
> horrible (and will not build) example I was trying to get to work.

I think our examples were pretty close already, but here's also your file. :)
--------------eNldNmG8FKXO6slpRWvrzn9e
Content-Type: text/rust; charset=UTF-8; name="rust_debugfs2.rs"
Content-Disposition: attachment; filename="rust_debugfs2.rs"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKCi8vIENvcHlyaWdodCAoQykg
MjAyNSBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgov
LyBDb3B5cmlnaHQgKEMpIDIwMjUgVGhlIExpbnV4IEZvdW5kYXRpb24KCi8vISBTYW1wbGUg
ZGVidWdmcyBydXN0IG1vZHVsZSB0aGF0IGVtdWxhdGVzIHNvY19pbmZvIHRvIHRyeSB0byBz
ZWUganVzdCBob3cgd2VsbCB0aGUgYXBpIGNhbgovLyEgd29yay4uLgoKdXNlIGNvcmU6OmZt
dDsKdXNlIGtlcm5lbDo6Y19zdHI7CnVzZSBrZXJuZWw6OmRlYnVnZnM6OntEaXIsIFNjb3Bl
fTsKdXNlIGtlcm5lbDo6cHJlbHVkZTo6KjsKCm1vZHVsZSEgewogICAgdHlwZTogU29jSW5m
bywKICAgIG5hbWU6ICJydXN0X3NvY19pbmZvIiwKICAgIGF1dGhvcnM6IFsiR3JlZyBLcm9h
aC1IYXJ0bWFuIl0sCiAgICBkZXNjcmlwdGlvbjogIlJ1c3Qgc29jX2luZm8gc2FtcGxlIGRy
aXZlciIsCiAgICBsaWNlbnNlOiAiR1BMIiwKfQoKZm4gZm91bmRyeV9wcmludChmb3VuZHJ5
OiAmdTMyLCBmOiAmbXV0IGZtdDo6Rm9ybWF0dGVyPCdfPikgLT4gZm10OjpSZXN1bHQgewog
ICAgd3JpdGVsbiEoZiwgIkZvdW5kcnk6IHt9IiwgZm91bmRyeSkKfQoKLy8gRmFrZSAiaGFy
ZHdhcmUgU09DIGluZm8gb2JqZWN0IHRoYXQgaWRlYWxseSB3b3VsZCByZWFkIGZyb20gdGhl
IGhhcmR3YXJlIHRvIGdldCB0aGUgaW5mby4KLy8gRm9yIG5vdyBqdXN0IHVzZSBzb21lIGZh
a2UgZGF0YQojW2Rlcml2ZShEZWJ1ZyldCnN0cnVjdCBId1NvY0luZm8gewogICAgaWQ6IHUz
MiwKICAgIHZlcjogdTMyLAogICAgcmF3X2lkOiB1MzIsCiAgICBmb3VuZHJ5OiB1MzIsCiAg
ICBuYW1lOiAmJ3N0YXRpYyBDU3RyLAp9CgppbXBsIEh3U29jSW5mbyB7CiAgICBmbiBuZXco
KSAtPiBTZWxmIHsKICAgICAgICBTZWxmIHsKICAgICAgICAgICAgaWQ6IDEyMywKICAgICAg
ICAgICAgdmVyOiA0NTYsCiAgICAgICAgICAgIHJhd19pZDogNzg5LAogICAgICAgICAgICBm
b3VuZHJ5OiAwLAogICAgICAgICAgICBuYW1lOiBjX3N0ciEoImh3X3NvYyBuYW1lIiksCiAg
ICAgICAgfQogICAgfQp9CgpzdHJ1Y3QgU29jSW5mbyB7CiAgICBfZGVidWdfZGlyOiBEaXIs
CiAgICBfaHdfc29jX2luZm86IFBpbjxLQm94PFNjb3BlPEh3U29jSW5mbz4+PiwKfQoKaW1w
bCBrZXJuZWw6Ok1vZHVsZSBmb3IgU29jSW5mbyB7CiAgICBmbiBpbml0KF90aGlzOiAmJ3N0
YXRpYyBUaGlzTW9kdWxlKSAtPiBSZXN1bHQ8U2VsZj4gewogICAgICAgIC8vIFJlYWQgZnJv
bSB0aGUgaGFyZHdhcmUgYW5kIGdldCBvdXIgc3RydWN0dXJlIGluZm9ybWF0aW9uCiAgICAg
ICAgbGV0IGh3X3NvY19pbmZvID0gSHdTb2NJbmZvOjpuZXcoKTsKCiAgICAgICAgLy8gQ3Jl
YXRlIHRoZSByb290IGRpcmVjdG9yeQogICAgICAgIGxldCByb290ID0gRGlyOjpuZXcoY19z
dHIhKCJydXN0X3NvY19pbmZvIikpOwoKICAgICAgICBsZXQgc2NvcGUgPSBLQm94OjpwaW5f
aW5pdCgKICAgICAgICAgICAgLy8gQ3JlYXRlIGRpcmVjdG9yeSBzY29wZSwgdGhhdCBjb250
YWlucyBzb21lIGRhdGEgYW5kIGEgYnVuY2ggb2YgZmlsZXMgZXhwb3J0aW5nIHRoaXMKICAg
ICAgICAgICAgLy8gZGF0YS4KICAgICAgICAgICAgcm9vdC5zY29wZShod19zb2NfaW5mbywg
Y19zdHIhKCJod19zb2NfaW5mbyIpLCB8aHdfc29jX2luZm8sIGRpcnwgewogICAgICAgICAg
ICAgICAgZGlyLnJlYWRfb25seV9maWxlKGNfc3RyISgiaWQiKSwgJmh3X3NvY19pbmZvLmlk
KTsKICAgICAgICAgICAgICAgIGRpci5yZWFkX29ubHlfZmlsZShjX3N0ciEoInZlciIpLCAm
aHdfc29jX2luZm8udmVyKTsKICAgICAgICAgICAgICAgIGRpci5yZWFkX29ubHlfZmlsZShj
X3N0ciEoInJhd19pZCIpLCAmaHdfc29jX2luZm8ucmF3X2lkKTsKICAgICAgICAgICAgICAg
IGRpci5yZWFkX29ubHlfZmlsZShjX3N0ciEoIm5hbWUiKSwgJmh3X3NvY19pbmZvLm5hbWUp
OwogICAgICAgICAgICAgICAgZGlyLnJlYWRfY2FsbGJhY2tfZmlsZShjX3N0ciEoImZvdW5k
cnkiKSwgJmh3X3NvY19pbmZvLmZvdW5kcnksICZmb3VuZHJ5X3ByaW50KTsKICAgICAgICAg
ICAgfSksCiAgICAgICAgICAgIEdGUF9LRVJORUwsCiAgICAgICAgKT87CgogICAgICAgIGxl
dCBzb2NfaW5mbzogJkh3U29jSW5mbyA9ICZzY29wZTsKCiAgICAgICAgLy8gUHJpbnQgdGhl
IGNvbnRlbnRzIG9mIGBzb2NfaW5mb2AgdGhhdCB3ZXJlIG1vdmVkIGludG8gYHNjb3BlYC4K
ICAgICAgICBwcl9pbmZvISgiSHdTb2NJbmZvOiB7Oj99XG4iLCBzb2NfaW5mbyk7CgogICAg
ICAgIE9rKFNlbGYgewogICAgICAgICAgICBfZGVidWdfZGlyOiByb290LAogICAgICAgICAg
ICBfaHdfc29jX2luZm86IHNjb3BlLAogICAgICAgIH0pCiAgICB9Cn0K

--------------eNldNmG8FKXO6slpRWvrzn9e--

