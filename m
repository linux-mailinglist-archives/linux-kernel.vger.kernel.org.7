Return-Path: <linux-kernel+bounces-749890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E0CB15458
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872F9546E36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14ED26C396;
	Tue, 29 Jul 2025 20:29:10 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCF24BC09;
	Tue, 29 Jul 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820950; cv=none; b=aoSrZljUAhzFgzGAvuXuqY7Ka0meCPqE0kRYeGC/myhqpPaErlHMWCie+CsLnzqnj5hWR35XwAW8Bqg9cyYzfNazL52x14PRGa0sFWBCn386IVWV2nk1y7hqHHN6rHCW43svAg3GwUh5cC5jMpSHRGTVuQsYFtZisB/DrqlTK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820950; c=relaxed/simple;
	bh=K/ESj6Sz/97JrTPw4kiRo81vGVgN9ZMvzoFu/fbLcuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iscKT5TjpzVPbGiDsiS07QtsXKyryGF+9WLo6wd4QDh/En+vOMacrGhoN9wxxEjIIrbhuegq/QF3jPUtLiCATasWR2bzpN7dXHokp47oPUR78+LCf4fY+dumTVEiBKvKwETMidsif8yKokc3X9nS0u0Ekmk+89RSIhSfRI/KsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:88cc:2901:8df5:a4ee] (unknown [IPv6:2a02:8084:255b:aa00:88cc:2901:8df5:a4ee])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 01DE342332;
	Tue, 29 Jul 2025 20:29:05 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:88cc:2901:8df5:a4ee) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:88cc:2901:8df5:a4ee]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <bdfd8364-747c-4c8e-8505-f6474fe9c88e@arnaud-lcm.com>
Date: Tue, 29 Jul 2025 21:29:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] checkpatch.pl: Add warning for // comments on private
 Rust items
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: joe@perches.com, apw@canonical.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250729195615.34707-1-contact@arnaud-lcm.com>
 <CANiq72=8AYUX5Xv-QE5mrPhDLtY2Zg2C2_ah48tJHCbObAg95Q@mail.gmail.com>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: 
 <CANiq72=8AYUX5Xv-QE5mrPhDLtY2Zg2C2_ah48tJHCbObAg95Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175382094697.30941.11482877887250138229@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Oops, good catch Miguel, thanks !

On 29/07/2025 21:23, Miguel Ojeda wrote:
> On Tue, Jul 29, 2025 at 9:56 PM Arnaud Lecomte <contact@arnaud-lcm.com> wrote:
>> Background
> I think you meant to send a cover letter here (i.e. patch zero, rather
> than 1) -- you can generate one e.g. with `git format-patch
> --cover-letter`.
>
> (No need to resend just for this -- I would wait for some reviews or
> comments from maintainers)
>
> Thanks!
>
> Cheers,
> Miguel

