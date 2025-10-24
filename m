Return-Path: <linux-kernel+bounces-869496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E469EC08022
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD503BD331
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96B2E7186;
	Fri, 24 Oct 2025 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ig/NWESD"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB22E6CA3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336860; cv=none; b=JVm4ekRLcRIz//jY9wtFVz6SWPEZpgqOMYAsZzwYpuC3U0zPOuQON0e46r4wp8anUUHWBxoys+UojC+P0eEDszj/CDj3BPUQrCSAUZso/8btTqjyNuLFVM1XJBcELTMP0gG5tAI2V1EygduZzd2JKQAluNxHZ7ObvOAi0LNqb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336860; c=relaxed/simple;
	bh=QRmmUPZjD0Nl/pzvJDzPxygHUoc//WlZnhbayyftwX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQP3b3XZJ63EwQmAK8U1IKiJXwGJyaJk9Vsjil8a3l/RoNeVqeigqBRiFgCa8qsoUWOcp/arUkuIeTKyfLvXa2u2Zyspz7ieC23WpiMcwIGQ6OPpQ4854M3phrgYZCHOTOcA1YOuZSmmnnRGWC3X7F7eA+de9S2dLzrPa9Myqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ig/NWESD; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-784a5f53e60so30394387b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761336858; x=1761941658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRmmUPZjD0Nl/pzvJDzPxygHUoc//WlZnhbayyftwX4=;
        b=Ig/NWESDE+V92QIAs8zCk53vnQj51oYAK+pzbV212WD2G+yUvvKjvhTy9IiZvbfWWz
         47+14pJ65zdfrpG6ITUPgGZm3p7BsqVObqp8yKF3njxT8BlMatV4DGKQjGcuX7mvw5rw
         wkaXanPokV8WnRclwP200/vH3zEIeUmEOAPRs2pCQJSxGPALGqX1thYEGX6k+Wwm84v/
         NdQ370q4xL2lpiigeIrsFRbl2KvP8+CSXysI7CKHn5rv8nFVbHcT4dARO1NCK46uTteP
         FeJHPD2l+Y1kZLbGLMfGkcEoD3oBN1hCQNrX49yfL3iFzKxQPFMahCYqg/o4/8JuFskT
         ch0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761336858; x=1761941658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRmmUPZjD0Nl/pzvJDzPxygHUoc//WlZnhbayyftwX4=;
        b=ZFyzFFjR40TBWia/jtDiMrg07gSMRFoY8BQ39nAWgykLwcGQTjEB0StTb6LRMn/7dj
         9aHo0M8M6SNUoYG0LCDdqLPxf2ZW9CEiXvWmMGjfWx5Jh6VHlfgltQKwvPz/psTf/8au
         6IC9VLiHz7gNpQv1hofxWEYjd8cZY1L6GLZjzNHBNSuJKiSZb/b67453KM/8GiziTpgc
         GFcAWlnuLOJP4R8UETKrwuBVi9S+YEX0VnAu+dJfFLE4fJ2On7BXqtA7ZTWR6Pq9buGp
         yWoE0vFnSpGEM+ddX5z6Xhroq4vNA3w/NkLT0Et1swRpi6TkSdZ8KG8oI/2584X6uX+z
         3uzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9xoS32fntLWqK+MjQX6ETOpD7tCvfSW7VndL8TcNbV73XYF69h6CHb7YbYq8l5Q+tZd4uGpM8nc92BdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGbvP/0ikCS9MBvzLkvaSyllJUMtaRufFmy0IorszrTt8LZNc
	8S0MwZYehKJCukGfAzD6M8nkCZlLG+0PapeZX0Hy1LzPyRHA2QK006L5GtbLFZ1qbf+c48lFJAF
	BJB5GBQosQSJCNMXnHet+6peKit4I2+9TscQe7fvo
X-Gm-Gg: ASbGncs6dZU/FvHAPGgdps1UG1jUv5qP2qz/BK+TFFJhv3vCrNOZ8cRMZKq5X8mho+q
	07I4AxkpDiStsd79rvlsTVOalvVxzMrmfkq8vmy4Uyme7sUTj3fPh/Vpl69XKxQfR9N80shix6z
	LICwbXExE6xrlQpHsnLqa3GZkiNNqo0eQcgH7FeZq5sIOHKxGq1YWaYJ4EZskJHI5hf/SKl8qwM
	Adudog1eBXrAFi/ZLNHTQsHm/f4wwetpjhd98PoEeWhgKXJrFB0gsVNfMNCwg2z071wxOlfHv2G
	nD7AcanvKR7mr7OjMpWLuzIiQReOsl4WMku5
X-Google-Smtp-Source: AGHT+IHTpYbhZDmL6ruzEWH+gphI5m7Ialef1RNXjW82+6aaizHeKOCv9/XRyMcMq4hJKcNstGH8IXkZIyc1k4him6k=
X-Received: by 2002:a05:690e:12ca:b0:63e:2f32:cccb with SMTP id
 956f58d0204a3-63e2f32cee7mr16781408d50.10.1761336857579; Fri, 24 Oct 2025
 13:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022182301.1005777-1-joshwash@google.com> <20251022182301.1005777-3-joshwash@google.com>
 <20251023171445.2d470bb3@kernel.org> <CAJcM6BFTb+ASBwO+5sMfLZyyO4+MhWKp3AweXMJrgis9P7ygag@mail.gmail.com>
 <20251024131004.01e1bce7@kernel.org>
In-Reply-To: <20251024131004.01e1bce7@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Fri, 24 Oct 2025 13:14:06 -0700
X-Gm-Features: AWmQ_bm-8GreWoq_uf6j4SHvhOnHL6CyYtA5h03iWipus0wRS1EtWd4i-WIu02I
Message-ID: <CAJcM6BFnN2HSYy=3+ocx+-M=tZroba6wCz9Pxgc8hyS0szdD2w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] gve: Allow ethtool to configure rx_buf_len
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 1:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 24 Oct 2025 11:17:04 -0700 Ankit Garg wrote:
> > > Please plumb extack thru to here. It's inside struct netdev_bpf
> >
> > Using extack just for this log will make it inconsistent with other
> > logs in this method. Would it be okay if I send a fast follow patch to
> > use exstack in this method and others?
>
> Could you make it part of this series, tho?

Absolutely. Will include in v2.

