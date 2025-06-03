Return-Path: <linux-kernel+bounces-672258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B7ACCCEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688C41704E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F4288CB4;
	Tue,  3 Jun 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b="NZYs77jj"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEA288CA2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975271; cv=none; b=ePMqxt2VACAc+BeXs8K2VflQudK3F8eQcxm3GEvBEtLjP2vqMOHK4o+EuiprRGMePCeqg2z43NIjXIhHAuzqx/OynfbgJnEbd2ElU+joSWeZxhepG+I0RI/wxIU0jUvhwAYJYs5Z9jCzG8tX8B+sagobYM91Rl1/tq+08370/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975271; c=relaxed/simple;
	bh=iGeXfLl7IWjLNNVm59Z7FuRkNW0L3x382uxZjTlgwJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYznyfkNk/wx/miQ2LcCIEtgpp9Yd3iIHft4ccPOQvbYRRiBwQs1GINvg5tnDNqzUQBrUjEEjEPY6v3ago3oNkSLceM72qWFVByLK9DSgYsEjRHV3P00n7dJEIkx13vWpuPQ6g24mISWnFKq6URiWk3EcohPZazWiY3GNvnSO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de; spf=pass smtp.mailfrom=tometzki.de; dkim=pass (2048-bit key) header.d=riscv-rocks.de header.i=@riscv-rocks.de header.b=NZYs77jj; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riscv-rocks.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tometzki.de
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5307e208234so3246123e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1748975269; x=1749580069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F84xp5anr9EIAmscjiL0kEmCw2MqV+hSPCs19dt7n58=;
        b=NZYs77jjFGa0tjkcMjzVodcG/hjvGbWOHyitf4m9SGiyVsB+Ms5fK+EKug0pFqsxEL
         bk1hBB8nr3jd3JLw65xSINNFO6qeI+sP4UCY4DalHA4nStkK1oEqh6oLDAo8baO1oqQw
         xIB4z2AbuICaGWFLMSEfAxiy4SqvPW1Yxs9Y1i4qSb62xcnyKUqooAnh3swT58NBbaJX
         tXHG52cBXfiPWO2OFp7de4lC7G1cZN6z4NZ6upGBLBBB+CfWcF6g8+HXGHVNJvagRZ/s
         NRNipRnXncKO0oH22Rp69tYFvkO9m5h1rJpqERy5pbIbtFiAU8VKXcxZxN3woS2feZni
         ufLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975269; x=1749580069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F84xp5anr9EIAmscjiL0kEmCw2MqV+hSPCs19dt7n58=;
        b=qiDhhufOoMICTAdbcQi/zTn4fRVRk214UwRGHNR21CxPOy7FuowVxUzS7LJc6YRiac
         uNIKAHEG1cFxNgonMxCWUxuWb2pQ+UfJO6b890t9zRr3cR5thcweVNgRAYOL2Jgrtu5k
         Uot1olo+wWmFJHO7A4GhzHi+yxFJUjtpHPbLZg5AI23U5hmdl8IXNuhlZ9GRDykP3E55
         6nKNJ4xyxT9NhY1/5lBjM4l3EV6jfhAwEwpFlsFIp7HcEqTnZLvpPp/NAO3CtRtfeArD
         Zu3JL29FgMvrEYECTI4GDMeo7gTPdhmWRZMRKtux5oGfS5htdDF9pqmdrNelH5GV7pT3
         CU4g==
X-Forwarded-Encrypted: i=1; AJvYcCV72Im1D/Kc4Tc7ONDtSgTxOOXXHlaIxDlpfH3fjGyuDHagzKmQe9TBa+WJBccNd1SGxLgwyrESKB08R8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSqHdX4DFiykYv5yU60QaR+ptCWcu+SKARkhrQA1en0kiqf3p
	l4WIrBb/RYZJ4BF2t95ktwI9ShcI7lucQ1YKVORNKbKUffbMxRVhm961I4Ai1PishfMAO3QSXKe
	J4oiUuz6TrIsMpRxeBBWkuNfY/VZ6zRr++cgpvMuQqA==
X-Gm-Gg: ASbGncv+2LjeVSme2/RFgnI91Vuh33WSpxKpNCUBeolt6CqGNIQdk9liD2EagQyJaHA
	BDmuM8t+vFVuYR5GWzFRZ2dvTffd7skailgQUZrXxTT+Nu5ZL/MfD9ePY2rCshdF45fVixRK5Tz
	hJ8ufqM+kU+K2SyXEYhYSK37731CrtcnKFm2fvgDS7IP0tDekmCAEJXKp4hFXovxM6lYBwfP6FK
	s0=
X-Google-Smtp-Source: AGHT+IFv8GHk0B9iWYVCI5VP7cxO969puIxjjsFGSnK2bTrRJmgjBMCCrvl+7lxurp59nHqxat5XTMnZs2jJfWTVEQ8=
X-Received: by 2002:a05:6122:a20:b0:523:e2bd:b937 with SMTP id
 71dfb90a1353d-530c7228a4bmr21638e0c.3.1748975268814; Tue, 03 Jun 2025
 11:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0107019736e3a599-79e58a4a-0dfa-4f43-aeaf-4a4208845b32-000000@eu-central-1.amazonses.com>
 <DM3PPF63A6024A98E210FB9D166A3CD1316A36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAL=B37=-q=Veghr7bo2GGiy1eyKP_xF0g8SeK5Lu6uKTVZgxoQ@mail.gmail.com> <DM3PPF63A6024A97BAB8D43C0FAEB7078BCA36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A97BAB8D43C0FAEB7078BCA36DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Damian Tometzki <damian@riscv-rocks.de>
Date: Tue, 3 Jun 2025 20:27:37 +0200
X-Gm-Features: AX0GCFuB4_rQMwEL07mw7f3u5FtJK_CUHLQmdUhe4u0U3JD39iRyYmLxlHpgGoc
Message-ID: <CAL=B37mvp3jfTbsg1DjEMxv5UU-sg27N+vkuUY5059yrzTQz0w@mail.gmail.com>
Subject: Re: [wireless] WARNING in iwl_mvm_sta_rx_agg+0x9d3/0xb70 [iwlmvm]
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 8:22=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> > If you need a kernel trace, I can provide a trace-cmd log. Please confi=
rm which
> > events are relevant ?
> > My idee ?
> > sudo trace-cmd record -e mac80211 -e cfg80211
>
> trace-cmd record  -T -e cfg80211 -e mac80211 -e iwlwifi_ucode  -e iwlwifi=
 -e console -e iwlwifi_msg -e mac80211_msg
>
Hi
the most events in the trace-com doesnt exist. Need something to add
into the kernel config ?

Damian

