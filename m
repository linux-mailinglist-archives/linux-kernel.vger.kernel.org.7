Return-Path: <linux-kernel+bounces-810737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06825B51EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08F597B3FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4062DECD6;
	Wed, 10 Sep 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhVqs87O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96B26B777;
	Wed, 10 Sep 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524232; cv=none; b=CP21uNW4lENkM5X14Cyyjg3XQIFjKT7pjWMUONKA2Cq7195+OgSS4tOvxDod2cYu0S0c/bvU7htRZFaJvyN3f8hlSYCO/cDU3RhKITDAB8dfbMAOmhWoMBKm3P+5/LWX3kFMMU30AdbiGZ+Fy9WlPS4/Xeia4Mir//XoSLhbLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524232; c=relaxed/simple;
	bh=PW76yThY2gj9z7rD5xixHiYA1fdwTSwz1aZ0Fy8V/Q8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KcQCaNSY1oDbzPTgC24bPP+bYEyEt56lvn5wNt0W7dScSkIli/skkOD838i+Xn/iP7LsNTm3jDlK2PyIkiSwxlWZ5lSrtjpf+x9bCufy/hMS9ewBH4UaQd4DaxngvRjt9+Y5qj3jU77/f4mQFbAJM5Rfg9rDTk4lCsUc2/3760w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhVqs87O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DCFC4CEEB;
	Wed, 10 Sep 2025 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757524232;
	bh=PW76yThY2gj9z7rD5xixHiYA1fdwTSwz1aZ0Fy8V/Q8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=XhVqs87O5vwpjXJZuz/l3R+3PlT9EsG9htJigQx5KGKzbC4D0lzNDRopdYC/X+6bm
	 VwK3Wz2+9nQ2XeUK9tKarluTxL1WDOWZMLy3Aph5g3z6tnNu6UfawqXGNmleALZLnd
	 x/IAitRwky2u3Iez09gP4tFErPpSXTB8ZdsXoRJgPNGftLhPZWc3V32M8EKq5+Qt37
	 GOdroyHfcUbRIz2mt56P5tVJ4CwgFOfSXqtLpH2q4lyCqZGzXKdx6rah1KwQayDw17
	 SdrdvsjRxMkqMVKpHRpnqcWyqRCcSmPKITQelQx1xrwAu1HRKatnM+0CjGYqT4AdUO
	 66mywoU8R44ew==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 19:10:27 +0200
Message-Id: <DCPACBXOKLNF.1ZWCPVR4F9PFQ@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
Cc: "Dirk Behme" <dirk.behme@de.bosch.com>, "Matthew Maurer"
 <mmaurer@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Sami Tolvanen"
 <samitolvanen@google.com>, "Timur Tabi" <ttabi@nvidia.com>, "Benno Lossin"
 <lossin@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>
 <DCO4MP8YT3A8.2PFXX7VJ1STD@kernel.org>
 <2025091014-explicit-grafted-e849@gregkh>
 <ef5c0c7b-3fb3-4099-966c-62cf08d9b2b4@kernel.org>
 <2025091027-granny-squatted-c5b5@gregkh>
 <17254fe7-3dea-411b-b6a7-fa368ec548e7@kernel.org>
In-Reply-To: <17254fe7-3dea-411b-b6a7-fa368ec548e7@kernel.org>

On Wed Sep 10, 2025 at 5:43 PM CEST, Danilo Krummrich wrote:
> On 9/10/25 5:36 PM, Greg Kroah-Hartman wrote:
>> I've pushed these to driver-core-testing if you could fix it up as I
>> don't know what the other change was?
>
> Sure, will do.

* rust: debugfs: Add initial support for directories
* rust: debugfs: Add support for read-only files

    [ Fixup build failure when CONFIG_DEBUGFS=3Dn. - Danilo ]

* rust: debugfs: Add support for writable files

    [ Fix up Result<()> -> Result. - Danilo ]

* rust: debugfs: Add support for callback-based files

    [ Fix up Result<(), Error> -> Result. - Danilo ]

* samples: rust: Add debugfs sample driver

    [ Change ACPI ID "LNUXDEBF" to "LNUXBEEF". - Danilo ]

* rust: debugfs: Add support for scoped directories

    [ Fix up Result<(), Error> -> Result; fix spurious backtick in
      doc-comment. - Danilo ]

* samples: rust: Add scoped debugfs sample driver

    [ Rename "scoped_debugfs" -> "debugfs_scoped", fix up
      Result<(), Error> -> Result. - Danilo ]

