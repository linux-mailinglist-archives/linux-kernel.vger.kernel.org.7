Return-Path: <linux-kernel+bounces-746077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBCBB122DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AC7580DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005652EF66B;
	Fri, 25 Jul 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SCVXZTuP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3724503C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463870; cv=none; b=SOo8dhmLYWD9+jCnEA78IHTmjkqUwgo39qPU3gXxztBdi+4b3fzwPqbEBWC2YU+soiLD06UkF0+4f6YoJ6WELwCCLIYFJ9J8JnMWV+xN+nJk7TWfWqUj1evobetOQ38QDvNv0taTcTvezPuL5jw1LglJ3cFrVuP7Gcuuw8doW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463870; c=relaxed/simple;
	bh=+hVGzKpufI9lmE0JC2FW8/1sTwpGoFkdU4EZYxZNZ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VscpRqwOMlEk+7gszfliCdc+8KJXAYt7b00Ov2Q9ue743tN6nsFewLP7EmqjUBryn3gp/93y2x/NdXkmwgDcLzjI/QkXMcUTDHGai2/H7+aX4dxjMZcnP0zESD2HM8znD6jdNoVF2kPfadIgsRVKnX8jJDr3WNrpPFccjBLl6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SCVXZTuP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so1155256f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753463865; x=1754068665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhUA94nOMYSBuKbo1SHT8sK1olilpHe1T/Kl9K2EGxU=;
        b=SCVXZTuPiW6FX7zUPu3zzoCwQSNcyrRWk/9H8cDpU0eLMmwK0DIBDn4ePf7zthZPwB
         JSHcmKDLYRXFeSo0WH6p7qUjixa+T3zZigQk8NMeg/03qjh9EfzEFnfUCCM3zpK8ePAm
         iNljosTtZEP89Z2WiBar8lBUW3GwNOWdgFqxrgRHZeZUeR26HM88GnkxsKsoRXtwBI9m
         u4HVINVABROMBPigRs6ODB15oQcviWK+uPsekJt+OQEMmvdSbxgB5KJ1g/XIXyvoKf15
         pl4dvPntvWozRzfUgzU8cLByJn1YQp47N/CfnICzdTmo8IlOqXf/n3I6GNMvPcjHP/NA
         CpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753463865; x=1754068665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhUA94nOMYSBuKbo1SHT8sK1olilpHe1T/Kl9K2EGxU=;
        b=xSWKyyPQdtkxcrlqeNgAEXbq2Ym9ZmughfwUaojwrwAGQtZmd5c6x50KVtTi56i8ej
         eqR3w2txaHMhdQNHuMXltvVY6nZm3yQreSyXrZZBz1PqPz4XVmNIXDtgn469xbt225pn
         RyjMBZYe5aIp7sO1nZS0ymzPRkaYnK/9+RQkAS1NnIFbrdlVRVW0Jqzb5C4ytqwjxXZ4
         Fxcq8r4ovvWxJF8k4eG6egqKPTx9YMD1R6kOAc9W8dJFK6SyDHQXO6L226yghVbb+PUK
         WxBxIouidisYud3YQXkolLe5POTJYTNpmkGLDCXp8eluE76QuGzp2NXE35J+3hM4+6o4
         f98w==
X-Forwarded-Encrypted: i=1; AJvYcCUqPwLKQln+aIk+0K2f4H1EZcyajl4k/cGJ4sezAY4nhz/tB5nyr7FPI+XaCfyGANZvn55w7T/0jjIkMow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWcvy3r2z84hM9pa7S1SYflrCLt+V183EAvkBY+tLxObWYHpf
	mgMx8DK6OmMkOKoFNH6yeenP2+jR3vA5hiDsI8Yp3uwd9Lizk2y14XpP5kqgD8mfZpcEUn3MQpK
	n3G6b
X-Gm-Gg: ASbGncuzp4eUOQ6Gmoa/kJJ9kTowOOMjEyk0KOFZNa6A5XVmL2AfbAB8b3XmrW39+xd
	Jwqe4gCgggfmKdKdD3qVxBa2Z9KI6H92nU47ZMfZld5tbMTlUeAUDh7h5Y7HjbswtJsJm170yWG
	RzXX+NHFiS1h4iSK7Ot0bTHBLmf09ZHdhtJmnTfCZCzYCSSe+C8ZZjhewiP3JBSfRebU5/e2VkX
	i9qfG3IvkODK8Dj9p8hLEVikE3wXIr2yn9w9nYr6aSStOFzmRFoliR4BE9z2HJJ3aBkn5k8IKqU
	eJfaxSknZcdU9yipcHUAqT0terP+UdvlXxfncVMqPxZxyewXCRpED73K26sas18sPho7D2M4+kY
	eeOEiKYbBUSltTdczq8DGIKFd+llkbAXaZddJAimZPg==
X-Google-Smtp-Source: AGHT+IGED6hE/H3FiLAQaw3Q6tpwuny6EUSbmo6qDEjVUj5GTtFe+2hNzxZsjW6l4tjrfQfhWnPSIQ==
X-Received: by 2002:a5d:5850:0:b0:3a4:ee3f:8e1e with SMTP id ffacd0b85a97d-3b776663858mr2940721f8f.39.1753463865251;
        Fri, 25 Jul 2025 10:17:45 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac66ed6sm3289315e9.28.2025.07.25.10.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:17:44 -0700 (PDT)
Date: Fri, 25 Jul 2025 19:17:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com, gaoyingjie@uniontech.com
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
Message-ID: <htzudoa4cgius7ncus67axelhv3qh6fgjgnvju27fuyw7gimla@uzrta5sfbh2w>
References: <20250722112733.4113237-1-chenridong@huaweicloud.com>
 <kfqhgb2qq2zc6aipz5adyrqh7mghd6bjumuwok3ie7bq4vfuat@lwejtfevzyzs>
 <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zkxkzcqexzi4w2bp"
Content-Disposition: inline
In-Reply-To: <7f36d0c7-3476-4bc6-b66e-48496a8be514@huaweicloud.com>


--zkxkzcqexzi4w2bp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root
 destruction to avoid hung_tasks
MIME-Version: 1.0

On Fri, Jul 25, 2025 at 09:42:05AM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> > On Tue, Jul 22, 2025 at 11:27:33AM +0000, Chen Ridong <chenridong@huawe=
icloud.com> wrote:
> >> CPU0                            CPU1
> >> mount perf_event                umount net_prio
> >> cgroup1_get_tree                cgroup_kill_sb
> >> rebind_subsystems               // root destruction enqueues
> >> 				// cgroup_destroy_wq
> >> // kill all perf_event css
> >>                                 // one perf_event css A is dying
> >>                                 // css A offline enqueues cgroup_destr=
oy_wq
> >>                                 // root destruction will be executed f=
irst
> >>                                 css_free_rwork_fn
> >>                                 cgroup_destroy_root
> >>                                 cgroup_lock_and_drain_offline
> >>                                 // some perf descendants are dying
> >>                                 // cgroup_destroy_wq max_active =3D 1
> >>                                 // waiting for css A to die
> >>
> >> Problem scenario:
> >> 1. CPU0 mounts perf_event (rebind_subsystems)
> >> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction w=
ork
> >> 3. A dying perf_event CSS gets queued for offline after root destructi=
on
> >> 4. Root destruction waits for offline completion, but offline work is
> >>    blocked behind root destruction in cgroup_destroy_wq (max_active=3D=
1)
> >=20
> > What's concerning me is why umount of net_prio hierarhy waits for
> > draining of the default hierachy? (Where you then run into conflict with
> > perf_event that's implicit_on_dfl.)
> >=20
>=20
> This was also first respond.
>=20
> > IOW why not this:
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -1346,7 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_roo=
t *root)
> >=20
> >         trace_cgroup_destroy_root(root);
> >=20
> > -       cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
> > +       cgroup_lock_and_drain_offline(cgrp);
> >=20
> >         BUG_ON(atomic_read(&root->nr_cgrps));
> >         BUG_ON(!list_empty(&cgrp->self.children));
> >=20
> > Does this correct the LTP scenario?
> >=20
> > Thanks,
> > Michal
>=20
> I've tested this approach and discovered it can lead to another issue tha=
t required significant
> investigation. This helped me understand why unmounting the net_prio hier=
archy needs to wait for
> draining of the default hierarchy.
>=20
> Consider this sequence:
>=20
> mount net_prio			umount perf_event
> cgroup1_get_tree
> // &cgrp_dfl_root.cgrp
> cgroup_lock_and_drain_offline
> // wait for all perf_event csses dead
> prepare_to_wait(&dsct->offline_waitq)
> schedule();
> 				cgroup_destroy_root
> 				// &root->cgrp, not cgrp_dfl_root
> 				cgroup_lock_and_drain_offline
								perf_event's css (offline but dying)

> 				rebind_subsystems
> 				rcu_assign_pointer(dcgrp->subsys[ssid], css);
> 				dst_root->subsys_mask |=3D 1 << ssid;
> 				cgroup_propagate_control
> 				// enable cgrp_dfl_root perf_event css
> 				cgroup_apply_control_enable
> 				css =3D cgroup_css(dsct, ss);
> 				// since we drain root->cgrp not cgrp_dfl_root
> 				// css(dying) is not null on the cgrp_dfl_root
> 				// we won't create css, but the css is dying

				What would prevent seeing a dying css when
				cgrp_dfl_root is drained?
				(Or nothing drained as in the patch?)

				I assume you've seen this warning from
				cgroup_apply_control_enable
				WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt)); ?


> 							=09
> // got the offline_waitq wake up
> goto restart;
> // some perf_event dying csses are online now
> prepare_to_wait(&dsct->offline_waitq)
> schedule();
> // never get the offline_waitq wake up
>=20
> I encountered two main issues:
> 1.Dying csses on cgrp_dfl_root may be brought back online when rebinding =
the subsystem to cgrp_dfl_root

Is this really resolved by the patch? (The questions above.)

> 2.Potential hangs during cgrp_dfl_root draining in the mounting process

Fortunately, the typical use case (mounting at boot) wouldn't suffer
=66rom this.

> I believe waiting for a wake-up in cgroup_destroy_wq is inherently risky,=
 as it requires that
> offline css work(the cgroup_destroy_root need to drain) cannot be enqueue=
d after cgroup_destroy_root
> begins.

This is a valid point.

> How can we guarantee this ordering? Therefore, I propose moving the drain=
ing operation
> outside of cgroup_destroy_wq as a more robust solution that would complet=
ely eliminate this
> potential race condition. This patch implements that approach.

I acknowledge the issue (although rare in real world). Some entity will
always have to wait of the offlining. It may be OK in cgroup_kill_sb
(ideally, if this was bound to process context of umount caller, not
sure if that's how kill_sb works).
I slightly dislike the form of an empty lock/unlock -- which makes me
wonder if this is the best solution.

Let me think more about this...

Thanks,
Michal

--zkxkzcqexzi4w2bp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIO8NQAKCRB+PQLnlNv4
CNCMAP0ehZX2MZ8AKiMVw3iEA1oIOfTMsc4M0MaNNlo7/ueYSAD+N/USGvkFFMln
MeNm/JjckXjWf1OQ2OPsn9fxLVb7sgg=
=qnrQ
-----END PGP SIGNATURE-----

--zkxkzcqexzi4w2bp--

