Return-Path: <linux-kernel+bounces-821640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F123B81D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6217BBCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788C42BEC27;
	Wed, 17 Sep 2025 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wscfrxqs"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFF2749E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142179; cv=none; b=KLrUCykXLF8WIj98fIwRhZx+LKR8/yr4aHsUei2l2UArFf3rh3xBE5swRpevYbEBNeID1mEfijg9FkkWKFG0fbTwvsBLUOr8tGkkQVEV9pUra0q5a3Ijh+rkYJAVcC55q3QlW4XAOvPmSyUah/BWPXjFdTpe+5sDpNES11ub3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142179; c=relaxed/simple;
	bh=w/9KXPZXjuM4uADuz/NcnSPq+DKuG5EI3D2PEkGP0tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYxJAr1odt7NSb+GPIQkYVXdNcyTn+q/UhNWaOah3ew/Eba+nN6I/r1s0PFNuQ9I5xyWxHb38V5qcJ4I4ynFZqXfVI1UhE4JYFlhIxMqIa47a+8FgRWZ66ZO9CUqDt6e1e6q1zhqJ994KhaRyODsqp/Mc/2toNxtTPoNhjgpakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wscfrxqs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2681645b7b6so16495ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758142177; x=1758746977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD0YaSX/nQIVvYRv3lyV8EiANlhEsiZAgU5SLemRN9I=;
        b=wscfrxqsljXl7Asqm6uZf5HMdW2CuIte5P0pcClOQ1vrUmjNq6gawnsSkyBh7ujN7w
         CjpLhPx1P0Fnvic5HNEVDgi6CfxsHY3i9u+dlHSW6cTQ0UzN/s8mJwxMfnnbzfAxjNgP
         EUStmmkEaGO0eMc5E9HiWxG32F6zNjPyaVS5Y6b5284wUMeS5611aUwf910tasMmtc+9
         WZ8NZn6lCWSgDwx9Ewnwu7pHwST22okrxDlxMvMas+uyuOJ93RCWmHtviatBEpoFZU+L
         F7WgK2hwGsJQJUDBgQuPGMmPWrTV1OKpYXTmkHuVr/JuDFSpFlUDk8c84EK4YLCWAj3N
         /OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142177; x=1758746977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD0YaSX/nQIVvYRv3lyV8EiANlhEsiZAgU5SLemRN9I=;
        b=BqyFWXaxlUREsc/iPy7cCcaAw9Dk/jxxSm8uzfIMBeqYaYDoLKTkXcK+emtmclQhNt
         Oagz5m1otuBbhJHuLy+ZrZmU5xUvNvUltdiu6Iuqw864YVRPZutVs0wKFHp5ZjkZHtyZ
         hpxwxLbGVWQAJjtCgzkEEhutC3j21Uzw2AlLBauJziGVuB+up+iaTf0OGfXIB7K4X/QA
         YUgzWu7iQqYCAaoUzYkYCp8XJoctyJffJkXYOvWRBd9uG8GPNwZ96U2DIUzw4gcExXRL
         cxFTydYQ6paZt8ZB6bTHaKmI0vrEvsKiixyCnLqoB/uUhtwFq0SL0fH78ALT6RQkTPIO
         4Xcw==
X-Forwarded-Encrypted: i=1; AJvYcCXizcWPDGiaITrQ8WPy+T+TH2K5As+8P8YW2nv+FBi9UrNqo7yyZYx1bVmlULpMg/FtrAYQEXb62Y1Qvlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/k+K52kWENFefgDlyoPTKTFkzq7iLhGbSVazP9PF38IquXT6F
	nRm2Jc3wUl76B8Y4dZBlJ5UHcY4CCkFgOiWcTgpVWhbU+D5Cj2CLXnuGa0on+2BizVfITcAvziV
	IlnJwfV9YpUycbX12c0CgHV67hSeltGoJV2kQZHZI
X-Gm-Gg: ASbGncuS42y6btIrbakwojptnw8IKyMRwUImIQp7tiXALR8QUgGr63sMRb4l/u039I7
	/g0nw3o8GMu+r7iLgAw2H6dOyXgU3ydBItmBJ6kjbriTOts3yfHK+MGm/2RSFx7faERsokygK+l
	AELG+Q5B2SWjDjpS4swisyn/lPvx165+N8YcIHEkU1Ak98HgFouSkKO/FrJH6mqAbtd1c2Dj604
	5OEItdEY+HSXPgozc97k4gvDL8GAll4ZiAivG3WlHiH4o12xy8RyJdV1H15tg==
X-Google-Smtp-Source: AGHT+IHqjlTORFQiuvLEqXF6/BhbNXVQJ7b03TKqe4M3ZkpkBdZNS4xem2H3lWDaAfxjJen7clHHtu2Plyvx7Bh3oM4=
X-Received: by 2002:a17:903:41c2:b0:269:2215:e672 with SMTP id
 d9443c01a7336-2692215eb63mr3809565ad.12.1758142176979; Wed, 17 Sep 2025
 13:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com> <20250904044653.1002362-6-irogers@google.com>
 <ef20fc6501c57d932024ad31323f90165caeae28.camel@intel.com>
In-Reply-To: <ef20fc6501c57d932024ad31323f90165caeae28.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 13:49:25 -0700
X-Gm-Features: AS18NWBzJyyrp8EQ8fF_epUjuvEmhQudR4HdGpFHYhy3lQJdye1qVwyqfxIRTGs
Message-ID: <CAP-5=fW05xhQ2TkQ2VgXwS9gUCtyZf=69L-7KksJDEWr8r+vuw@mail.gmail.com>
Subject: Re: [PATCH v6 05/22] perf jevents: Mark metrics with experimental
 events as experimental
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "Baker, Edward" <edward.baker@intel.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"xu.yang_2@nxp.com" <xu.yang_2@nxp.com>, "Biggers, Caleb" <caleb.biggers@intel.com>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "james.clark@linaro.org" <james.clark@linaro.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>, 
	"bgray@linux.ibm.com" <bgray@linux.ibm.com>, "Alt, Samantha" <samantha.alt@intel.com>, 
	"renyu.zj@linux.alibaba.com" <renyu.zj@linux.alibaba.com>, "acme@kernel.org" <acme@kernel.org>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:02=E2=80=AFAM Falcon, Thomas <thomas.falcon@inte=
l.com> wrote:
>
> On Wed, 2025-09-03 at 21:46 -0700, Ian Rogers wrote:
> > When metrics are made with experimental events it is desirable the
> > metric description also carries this information in case of metric
> > inaccuracies.
> >
> > Suggested-by: Perry Taylor <perry.taylor@intel.com>
>
> Does this need a Signed-off-by?

It does, I'll fix in v7.

Thanks,
Ian

> Thanks,
> Tom
>
> > ---
> >  tools/perf/pmu-events/metric.py | 44 +++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/me=
tric.py
> > index 62d1a1e1d458..2029b6e28365 100644
> > --- a/tools/perf/pmu-events/metric.py
> > +++ b/tools/perf/pmu-events/metric.py
> > @@ -10,11 +10,13 @@ from typing import Dict, List, Optional, Set, Tuple=
, Union
> >
> >  all_pmus =3D set()
> >  all_events =3D set()
> > +experimental_events =3D set()
> >
> >  def LoadEvents(directory: str) -> None:
> >    """Populate a global set of all known events for the purpose of vali=
dating Event names"""
> >    global all_pmus
> >    global all_events
> > +  global experimental_events
> >    all_events =3D {
> >        "context\\-switches",
> >        "cpu\\-cycles",
> > @@ -32,6 +34,8 @@ def LoadEvents(directory: str) -> None:
> >              all_pmus.add(x["Unit"])
> >            if "EventName" in x:
> >              all_events.add(x["EventName"])
> > +            if "Experimental" in x and x["Experimental"] =3D=3D "1":
> > +              experimental_events.add(x["EventName"])
> >            elif "ArchStdEvent" in x:
> >              all_events.add(x["ArchStdEvent"])
> >        except json.decoder.JSONDecodeError:
> > @@ -61,6 +65,18 @@ def CheckEvent(name: str) -> bool:
> >    return name in all_events
> >
> >
> > +def IsExperimentalEvent(name: str) -> bool:
> > +  global experimental_events
> > +  if ':' in name:
> > +    # Remove trailing modifier.
> > +    name =3D name[:name.find(':')]
> > +  elif '/' in name:
> > +    # Name could begin with a PMU or an event, for now assume it is no=
t experimental.
> > +    return False
> > +
> > +  return name in experimental_events
> > +
> > +
> >  class MetricConstraint(Enum):
> >    GROUPED_EVENTS =3D 0
> >    NO_GROUP_EVENTS =3D 1
> > @@ -82,6 +98,10 @@ class Expression:
> >      """Returns a simplified version of self."""
> >      raise NotImplementedError()
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    """Are experimental events used in the expression?"""
> > +    raise NotImplementedError()
> > +
> >    def Equals(self, other) -> bool:
> >      """Returns true when two expressions are the same."""
> >      raise NotImplementedError()
> > @@ -249,6 +269,9 @@ class Operator(Expression):
> >
> >      return Operator(self.operator, lhs, rhs)
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    return self.lhs.HasExperimentalEvents() or self.rhs.HasExperimenta=
lEvents()
> > +
> >    def Equals(self, other: Expression) -> bool:
> >      if isinstance(other, Operator):
> >        return self.operator =3D=3D other.operator and self.lhs.Equals(
> > @@ -297,6 +320,10 @@ class Select(Expression):
> >
> >      return Select(true_val, cond, false_val)
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    return (self.cond.HasExperimentalEvents() or self.true_val.HasExpe=
rimentalEvents() or
> > +            self.false_val.HasExperimentalEvents())
> > +
> >    def Equals(self, other: Expression) -> bool:
> >      if isinstance(other, Select):
> >        return self.cond.Equals(other.cond) and self.false_val.Equals(
> > @@ -345,6 +372,9 @@ class Function(Expression):
> >
> >      return Function(self.fn, lhs, rhs)
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    return self.lhs.HasExperimentalEvents() or (self.rhs and self.rhs.=
HasExperimentalEvents())
> > +
> >    def Equals(self, other: Expression) -> bool:
> >      if isinstance(other, Function):
> >        result =3D self.fn =3D=3D other.fn and self.lhs.Equals(other.lhs=
)
> > @@ -384,6 +414,9 @@ class Event(Expression):
> >      global all_events
> >      raise Exception(f"No event {error} in:\n{all_events}")
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    return IsExperimentalEvent(self.name)
> > +
> >    def ToPerfJson(self):
> >      result =3D re.sub('/', '@', self.name)
> >      return result
> > @@ -416,6 +449,9 @@ class MetricRef(Expression):
> >    def Simplify(self) -> Expression:
> >      return self
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    return False
> > +
> >    def Equals(self, other: Expression) -> bool:
> >      return isinstance(other, MetricRef) and self.name =3D=3D other.nam=
e
> >
> > @@ -443,6 +479,9 @@ class Constant(Expression):
> >    def Simplify(self) -> Expression:
> >      return self
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    return False
> > +
> >    def Equals(self, other: Expression) -> bool:
> >      return isinstance(other, Constant) and self.value =3D=3D other.val=
ue
> >
> > @@ -465,6 +504,9 @@ class Literal(Expression):
> >    def Simplify(self) -> Expression:
> >      return self
> >
> > +  def HasExperimentalEvents(self) -> bool:
> > +    return False
> > +
> >    def Equals(self, other: Expression) -> bool:
> >      return isinstance(other, Literal) and self.value =3D=3D other.valu=
e
> >
> > @@ -527,6 +569,8 @@ class Metric:
> >      self.name =3D name
> >      self.description =3D description
> >      self.expr =3D expr.Simplify()
> > +    if self.expr.HasExperimentalEvents():
> > +      self.description +=3D " (metric should be considered experimenta=
l as it contains experimental events)."
> >      # Workraound valid_only_metric hiding certain metrics based on uni=
t.
> >      scale_unit =3D scale_unit.replace('/sec', ' per sec')
> >      if scale_unit[0].isdigit():

